class CommandRunner:
    @staticmethod
    def get_optimized_env():
        def traverse(rootpath, paths, indices):
            from pathlib import Path

            cwd = Path.cwd()
            for i, p in enumerate(paths):
                if p.samefile(rootpath) and (not p.samefile(cwd)):
                    indices.add(i)
            for p in rootpath.iterdir():
                if p.is_dir():
                    traverse(p, paths, indices)

        import os
        from pathlib import Path
        from .path import root

        rootpath = root()
        environ = os.environ
        path = environ["PATH"]
        paths = [Path(p.strip()) for p in path.split(":")]
        indices = set()
        traverse(rootpath, paths, indices)
        indices = list(indices)
        for i in sorted(indices, reverse=True):
            paths.pop(i)
        environ["PATH"] = ":".join([str(p).strip() for p in paths])
        return environ

    def __init__(self):
        self.env = CommandRunner.get_optimized_env()

    def run(self, args: list):
        from subprocess import run, PIPE

        return run(args, stdout=PIPE, stderr=PIPE, env=self.env)
