python
import os, subprocess, sys
paths = subprocess.check_output('eval "$(pyenv init -)"; pyenv activate gdb; python -c "import os,sys;print(os.linesep.join(sys.path).strip())"',shell=True).decode("utf-8").split()
sys.path.extend(paths)
end

source ~/Repositories/gef/gef.py

