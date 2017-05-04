data_create:
	cd ../../02_keystone && make db_create
	cd ../../03_glance && make db_create
	cd ../../03_glance && make mc_create
	cd ../../04_nova && make db_create

data_remove:
	cd ../../02_keystone && make db_remove
	cd ../../03_glance && make db_remove
	cd ../../03_glance && make mc_remove
	cd ../../04_nova && make db_remove
