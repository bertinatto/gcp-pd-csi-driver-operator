FROM registry.svc.ci.openshift.org/openshift/release:golang-1.15 AS builder
WORKDIR /go/src/github.com/openshift/gcp-pd-csi-driver-operator
COPY . .
RUN make

FROM registry.svc.ci.openshift.org/openshift/origin-v4.0:base
COPY --from=builder /go/src/github.com/openshift/gcp-pd-csi-driver-operator/gcp-pd-csi-driver-operator /usr/bin/
COPY manifests /manifests
ENTRYPOINT ["/usr/bin/gcp-pd-csi-driver-operator"]
LABEL io.k8s.display-name="OpenShift GCP PD CSI Driver Operator" \
	io.k8s.description="The GCP PD CSI Driver Operator installs and maintains the GCP PD CSI Driver on a cluster."
