class CommandRunner:
    @staticmethod
    def get_optimized_env():
        def traverse(path):
            for i, p in enumerate(paths):
                if p.samefile(path) and (not p.samefile(cwd)):
                    indices.add(i)
            for p in path.iterdir():
                if p.is_dir():
                    traverse(p)

        import os
        from pathlib import Path
        from .path import root

        rootpath = root()
        env = os.environ
        path = env["PATH"]
        paths = [Path(p.strip()) for p in path.split(":")]
        indices = set()
        cwd = Path.cwd()
        traverse(rootpath)
        indices = list(indices)
        for i in sorted(indices, reverse=True):
            paths.pop(i)
        env["PATH"] = ":".join([str(p).strip() for p in paths])
        return env

    def __init__(self):
        self.__env = CommandRunner.get_optimized_env()

    def run(self, args: list):
        from subprocess import run, PIPE

        return run(args, stdout=PIPE, stderr=PIPE, env=self.__env)
