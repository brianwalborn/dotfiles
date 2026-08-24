"""Pastel rainbow tab colors.

kitty loads this file when `tab_bar_style custom` is set and calls `draw_tab`
for every tab. All of the actual drawing is left to kitty's built-in powerline
renderer; the only thing done here is recoloring each tab so tabs cycle through
a pastel rainbow by position.

The neighboring tabs handed over in `extra_data` are recolored too, because the
powerline renderer picks the separator color out of the next tab.

Nothing here is hardcoded to a theme: the background comes from
`draw_data.default_bg`, so the pastels re-tune themselves when the `light` and
`dark` aliases swap themes.
"""

from kitty.fast_data_types import Color, Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_tab_with_powerline

# How much of a tab's pastel hue survives in its background when the tab is
# focused; the rest is pulled toward EMPHASIS, which lifts the focused tab above
# its neighbors.
ACTIVE_BACKGROUND_TINT = 0.8

BLACK = '#000000'

# How much of a tab's pastel hue survives in its background when the tab is not
# focused. Every tab stays visibly colored; the focused one is just brighter.
INACTIVE_BACKGROUND_TINT = 0.65

# Tab titles are always dark, because the pastels are light in either theme.
INK = '#18181C'

WHITE = '#FFFFFF'

PASTEL_RAINBOW = (
    '#FFADAD',  # red
    '#FFD6A5',  # orange
    '#FDFFB6',  # yellow
    '#CAFFBF',  # green
    '#9BF6FF',  # cyan
    '#A0C4FF',  # blue
    '#BDB2FF',  # violet
)


def as_integer(color: str) -> int:
    """Pack a #RRGGBB string into the integer form kitty's tab colors expect."""
    return int(color.lstrip('#'), 16)


def blended(color: int, other: int, fraction: float) -> int:
    """Mix `fraction` of `color` with `1 - fraction` of `other`."""
    return sum(
        round(((color >> shift) & 0xFF) * fraction + ((other >> shift) & 0xFF) * (1 - fraction)) << shift
        for shift in (0, 8, 16)
    )


def colorized(background: Color, tab: TabBarData | None, index: int) -> TabBarData | None:
    """Copy `tab` with its slot in the pastel rainbow baked into its colors.

    Every tab is a block of its pastel with a dark title on it. The focused tab
    gets its pastel pushed away from the background and the rest are muted toward
    it, so the rainbow reads as one row without the focused tab getting lost in
    it. Which direction "away" is depends on the theme: pastels brighten toward
    white on a dark background and deepen toward black on a light one.
    """
    if tab is None:
        return None
    emphasis = as_integer(WHITE if background.is_dark else BLACK)
    pastel = as_integer(PASTEL_RAINBOW[(index - 1) % len(PASTEL_RAINBOW)])
    return tab._replace(
        active_bg=blended(pastel, emphasis, ACTIVE_BACKGROUND_TINT),
        active_fg=as_integer(INK),
        inactive_bg=blended(pastel, int(background), INACTIVE_BACKGROUND_TINT),
        inactive_fg=as_integer(INK),
    )


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    # The cursor colors are what actually paint this tab: kitty sets them from the
    # uncolored tab before calling us, and the powerline renderer reads the tab's
    # background back off the cursor rather than off the tab. The recolored tabs
    # still have to be passed along, because the separator between two tabs is
    # drawn in the *next* tab's background.
    background = draw_data.default_bg
    colored_tab = colorized(background, tab, index)
    extra_data.prev_tab = colorized(background, extra_data.prev_tab, index - 1)
    extra_data.next_tab = colorized(background, extra_data.next_tab, index + 1)
    screen.cursor.bg = as_rgb(draw_data.tab_bg(colored_tab))
    screen.cursor.fg = as_rgb(draw_data.tab_fg(colored_tab))
    return draw_tab_with_powerline(
        draw_data, screen, colored_tab, before, max_tab_length, index, is_last, extra_data
    )
