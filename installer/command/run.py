def run(args: list):
    import subprocess

    return subprocess.run(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
