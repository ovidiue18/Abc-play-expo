"""
AstravexOS DSL — mini-limbajul pentru meniuri
Folosit de astravex_menus.py + build.py
"""

class Action:
    def __init__(self, kind, *args, **kwargs):
        self.kind = kind
        self.args = args
        self.kwargs = kwargs
    def __repr__(self):
        return f"Action({self.kind} {self.args})"

# helpers DSL — genereaza actiuni cmd
def REG(path, name, value, typ="REG_DWORD"):
    return Action("REG", path, name, value, typ)

def SVC(name, state="demand"):
    return Action("SVC", name, state)

def TASK(name, state="disable"):
    return Action("TASK", name, state)

def WINGET(pkg, args=""):
    return Action("WINGET", pkg, args)

def PS(script):
    return Action("PS", script)

def CMD(cmd):
    return Action("CMD", cmd)

def DW(path, name, val):
    return Action("REG", path, name, val, "REG_DWORD")

def SZ(path, name, val):
    return Action("REG", path, name, val, "REG_SZ")

def EXPL():
    return Action("EXPL")

def A(title, actions):
    """Grup de actiuni cu titlu"""
    return {"title": title, "actions": actions if isinstance(actions, list) else [actions]}

def IT(num, label, blocks, desc=""):
    """Item de meniu: numar, eticheta, lista de A()"""
    if not isinstance(blocks, list):
        blocks = [blocks]
    return {"num": str(num), "label": label, "blocks": blocks, "desc": desc}

class Menu:
    def __init__(self, id, title, subtitle, items, parent=None):
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.items = items
        self.parent = parent
    def labels(self):
        return [i["label"] for i in self.items]
