# ⚡️ One Minute ELK



🕒 Deploy a full ELK stack (Elasticsearch, Logstash, Kibana, Filebeat) on Kubernetes in under 60 seconds (Subject to cloud provisioning speeds. Usually works for kubernetes running in kind, k3d or minikube). A blazing-fast, secure, and extensible Kubernetes-native logging stack. Automatically ships logs from across your cluster to a centralized, TLS-enabled Elasticsearch backend — with custom parsing and real-time visualization in Kibana.

## 📦 Features

- ✅ 1-command setup via setup_elk_filebeat.sh
- 🔐 TLS encryption (CA-signed certificates)
- 🔐 Secure authentication using native Elasticsearch users
- 📄 Custom Logstash pipeline (Apache logs, JSON logs, etc.)
- 🌐 Kibana dashboard ready out-of-the-box
- 🌍 Filebeat DaemonSet with cross-namespace log collection
- 📁 Easy-to-edit filebeat.yml and pipeline.conf


## 🚀 Quickstart

Prerequisites: Kubernetes cluster (e.g., Minikube, Kind, EKS), `kubectl`, and `openssl`

```
git clone https://github.com/joeldsouza28/one-minute-elk.git
cd one-minute-elk
chmod +x setup_elk_filebeat.sh
./setup_elk_filebeat.sh
```

## 🔍 Verify the Setup

### Access Kibana:

```
kubectl port-forward svc/kibana -n logging 5601:5601
```

Open http://localhost:5601 in your browser.

Login credentials (auto-generated):

- Username: elastic

- Password: see tls/password.txt or output of `setup_elk_filebeat.sh`


## 📁 Directory Structure


```
elk-k8s-setup/
├── elastic/
│   ├── elasticsearch.yaml
│   ├── elasticsearch-pvc.yaml
│   ├── setup_elastic.sh
├── filebeat/
│   ├── filebeat-daemonset.yaml
│   ├── filebeat-rbac.yaml
│   ├── filebeat.yml
│   ├── setup_filebeat.sh
├── kibana/
│   ├── kibana.yaml
│   ├── setup_kibana.sh
├── logstash/
│   ├── logstash.yaml
│   ├── pipeline.conf
│   ├── setup_logstash.sh
├── tls/
│   ├── ca.crt
│   ├── ca.key
│   ├── ca.srl
│   ├── elasticsearch.crt
│   ├── elasticsearch.key
│   ├── generate_tls.sh
│   ├── get_password.sh
│   ├── san.cnf
├── .gitignore
├── README.md
├── setup_elk_filebeat.sh
```

## 🛠 Customization

### ➕ Add new parsing rules

Edit `pipeline.conf` and re-run:

```
bash logstash/setup_logstash.sh
```

### 🎯 Send logs from another namespace

Ensure pods in other namespaces write logs to `/var/log/containers`. Filebeat automatically discovers them.

## ✍️ Behind the Project


Read the full story and technical deep dive on [Medium →](https://medium.com/@joeldsouza28/one-minute-elk-stack-on-kubernetes-full-logging-setup-with-a-single-script-ba92aecb4379)
Why I built One Minute ELK, the challenges I faced, and how this project can accelerate your Kubernetes logging workflows.

## 🔐 Security Highlights

- Uses custom CA for TLS

- Encrypted communication:

    Kibana ↔ Elasticsearch

    Logstash ↔ Elasticsearch

- Auth via internal users (no anonymous access)

## 🧹 Cleanup

```
kubectl delete ns logging
```

## 🤝 Contributing
Pull requests and suggestions are welcome! Open an issue or fork the repo.

## 📄 License
MIT License

## 🙌 Acknowledgments

- [Elastic Stack](https://www.elastic.co/elastic-stack/)
- [Beats](https://www.elastic.co/beats)
- Inspired by real-world DevOps pain 😅
