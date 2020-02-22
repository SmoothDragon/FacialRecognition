# Makefile to install and remove intel openvino
#
# TODO: Not sure how to remove Google signing key
# make openvino to install openvino environment
# make rm-openvino to uninstall openvino environment

openvino-repo:
	dpkg --list | grep -q "ii  gnupg-curl" || (echo "Please install: gnupg-curl" && false)
	echo "deb [arch=amd64] https://apt.repos.intel.com/openvino/2019/ all main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2019.list
	sudo chmod a+r /etc/apt/sources.list.d/intel-openvino-2019.list
	sudo apt-key adv --fetch-keys https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
	sudo apt update

openvino: openvino-repo
	sudo apt install -y intel-openvino-runtime-ubuntu16-2019.3.376 intel-openvino-dev-ubuntu16-2019.3.376         
	sudo echo "use python anaconda3-2019.10" > /opt/intel/.envrc
	sudo chown -R tom /opt/intel

rm-openvino:
	sudo apt purge -y intel-openvino-runtime-ubuntu16-2019.3.376 intel-openvino-dev-ubuntu16-2019.3.376         
	# May have to erase direnv stuff

rm-openvino-repo: rm-openvino
	rm -f /etc/apt/sources.list.d/intel-openvino-2019.list
	sudo apt update
	sudo apt autoremove -y

install:
	ln -fs /opt/intel/openvino/deployment_tools/open_model_zoo/demos/python_demos/face_recognition_demo/ .
	pip install -r requirements.txt
	mkdir -p models
	./get_models.sh

uninstall:
	rm face_recognition_demo
	rm -rf models

# Utility for checking what installation files are present
check:
	ls /etc/apt/sources.list.d | grep openvino || true  # Show repository config files referencing OpenVino
	apt search intel-openvino-dev-ubuntu16


