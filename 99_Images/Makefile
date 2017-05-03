ImgNames = base
ImgNames += osclient
ImgNames += keystone
ImgNames += glance

# print ImageNames
all:
	@for ImgName in $(ImgNames); do \
		echo $$ImgName; \
	done

CirrosPath = "../01_osclient/images"
CirrosFile = "$(CirrosPath)/cirros-0.3.5-x86_64-disk.img"
CirrosShaSumCMD = shasum -a 256 $(CirrosFile) | awk '{print $$1;}'
CirrosShaSumDF = 'e137062a4dfbb4c225971b67781bc52183d14517170e16a3841d16f962ae7470'
CirrosURL = http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img
DLCirrosCMD = curl -L -o $(CirrosFile) $(CirrosURL)
build:
	@if [ ! -f $$CirrosFile ]; then \
		$(DLCirrosCMD); \
	else \
		if [ ! `${CirrosShaSumCMD}` == ${CirrosShaSumDF} ]; then \
			echo 'file:' `${CirrosShaSumCMD}`; \
			echo 'default:' ${CirrosShaSumDF}; \
			$(DLCirrosCMD); \
		fi; \
	fi
	@for ImgName in $(ImgNames); do \
		echo "-> build $$ImgName"; \
		cd ../*$$ImgName && make rebuild; \
	done

save:
	@for ImgName in $(ImgNames); do \
		echo "-> save $$ImgName"; \
		docker save -o mooxe_openstack_$$ImgName.img.tar mooxe/openstack/$$ImgName; \
	done

push:
	@for ImgName in $(ImgNames); do \
		echo "-> retag $$ImgName"; \
		docker tag mooxe/openstack/$$ImgName mooxe/openstack_$$ImgName; \
		echo "-> push $$ImgName"; \
		docker push mooxe/openstack_$$ImgName; \
	done

pull:
	@for ImgName in $(ImgNames); do \
		echo "-> pull $$ImgName"; \
		docker pull mooxe/openstack_$$ImgName; \
		echo "-> retag $$ImgName"; \
		docker tag mooxe/openstack_$$ImgName mooxe/openstack/$$ImgName; \
	done

download_check:
# SCP_OPTIONS
ifndef SCP_OPTIONS
	$(error SCP_OPTIONS is undefined)
endif
# SCP_USER
ifndef SCP_USER
	$(error SCP_USER is undefined)
endif
# SCP_HOST
ifndef SCP_HOST
	$(error SCP_HOST is undefined)
endif
# SCP_IMGPATH
ifndef SCP_IMGPATH
	$(error SCP_IMGPATH is undefined)
endif

# @SCP_OPTIONS
# @SCP_USER
# @SCP_HOST
# @SCP_IMGPATH
download: download_check
	@for ImgName in $(ImgNames); do \
		if [ ! -f mooxe_openstack_$$ImgName.img.tar ] ; then \
			echo "-> download $$ImgName"; \
			scp $$SCP_OPTIONS $$SCP_USER@$$SCP_HOST:$$SCP_IMGPATH/mooxe_openstack_$$ImgName.img.tar .; \
		fi \
	done

load:
	@for ImgName in $(ImgNames); do \
		echo "-> load $$ImgName"; \
		docker rmi -f mooxe/openstack/$$ImgName; \
		docker load -i mooxe_openstack_$$ImgName.img.tar; \
	done
