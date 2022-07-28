FROM    python:3.10 as builder
WORKDIR /srv
ENV     PDM_USE_VENV=False

RUN     pip install -U pip setuptools wheel
RUN     pip install pdm

COPY    pyproject.toml pdm.lock /srv/
COPY    src/ /srv/src
RUN     pdm install --check --prod --no-lock --no-editable



FROM    python:3.10
ENV     PYTHONPATH=/srv/pkgs

WORKDIR /srv
COPY    --from=builder /srv/__pypackages__/3.10/lib /srv/pkgs
CMD     ["python", "-m", "uvicorn", "--host", "0.0.0.0", "--port", "8000", "hello_world.main:app"]
