Sample application showing keyboard input on tvos.

Can demonstrate crash caused by dictation if we don't force Cinder's OpenGL context to be current.

Clone to the blocks/ directory of a Cinder implementation that supports tvos. For example, the `apple_tv` branch of [Sosolimited's Cinder fork](https://github.com/sosolimited/Cinder/tree/apple_tv). The latest commit on this branch fixes the issue within the draw loop. It will still demonstrate incorrect CPU/GPU usage statistics in XCode after dictation is used.
