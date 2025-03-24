local_resource(
    'minikube',
    cmd='./scripts/mk-start.sh',
    env={'CLUSTER_NAME': os.getenv('CLUSTER_NAME', 'mk')}
)

local_resource(
    'flux',
    cmd='./scripts/flux-bootstrap.sh',
    resource_deps=['minikube'],
    deps=['./scripts/flux-bootstrap.sh'],
    env={
        'CLUSTER_NAME': 'mk',
        'GITHUB_TOKEN': os.getenv('GITHUB_TOKEN', ''),
        'GITHUB_OWNER': 'coutug',
        'GITHUB_REPOSITORY': 'mk-playground',
        'GITHUB_BRANCH': 'main'
    }
)