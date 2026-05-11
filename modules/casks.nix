# casks.nix
_:
[
  # Communication
  { name = "discord"; greedy = true; }
  { name = "zoom"; greedy = true; }
  { name = "docker-desktop"; greedy = true; }

  # Productivity
  { name = "spotify"; greedy = true; }
  { name = "raycast"; greedy = true; }
  { name = "anytype"; greedy = true; }
  { name = "obsidian"; greedy = true; }

  # Browsers
  { name = "firefox"; greedy = true; }
  { name = "zen"; greedy = true; }

  # Development
  { name = "zed"; greedy = true; }

  # Utilities
  { name = "enpass"; greedy = true; }
  { name = "chatbox"; }
  { name = "sonic-pi"; greedy = true; }

  # Terminals
  { name = "ghostty"; greedy = true; }
]
