load('ext://helm_resource', 'helm_resource', 'helm_repo')

local_resource(
    'minikube',
    cmd='./scripts/mk-start.sh',
    deps=['./scripts/mk-start.sh'],
    env={'CLUSTER_NAME': os.getenv('CLUSTER_NAME', 'mk')}
)

helm_repo('cilium_repo',
    'https://helm.cilium.io'
)
helm_resource('cilium_release',
    chart='cilium/cilium',
    resource_deps=['cilium_repo'],
    namespace='kube-system',
    flags=[
        '--version=1.17.1',
        '--values=./tilt-utils/cilium-values.yaml'
    ]
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