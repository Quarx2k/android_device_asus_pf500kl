#QCRIL
QCRIL := libril-qc-1
QCRIL += libril-qc-qmi-1
QCRIL += libril-qcril-hook-oem
QCRIL += qcrilhook
QCRIL += qcrilmsgtunnel
QCRIL += qcrilhook.xml
QCRIL += libwmsts

#QMI
QMI := irsc_util
QMI += libidl
QMI += libqmi
QMI += libqmi_cci
QMI += libqmi_client_helper
QMI += libqmi_common_so
QMI += libqmi_csi
QMI += libqmi_encdec
QMI += libqmiservices
QMI += qmiproxy
QMI += qmi_config.xml
QMI += qmuxd

#PERIPHERAL MANAGER:
PERMGR := pm-service
PERMGR += libperipheral_client

#DATA
DATA := libconfigdb
DATA += libdsutils
DATA += libnetmgr
DATA += netmgrd
DATA += netmgr_config.xml

#SYSTEM HEALTH MONITOR
SYSTEM_HEALTH_MONITOR := libsystem_health_mon

#TIME_SERVICES
TIME_SERVICES := time_daemon TimeService libTimeService

#THERMAL-ENGINE
THERMAL_ENGINE := thermal-engine libthermalclient

#QUICKBOOT
QUICKBOOT := QuickBoot

#CNE
CNE := andsfCne.xml
CNE += cnd
CNE += cneapiclient
CNE += cneapiclient.xml
CNE += com.quicinc.cne
CNE += com.quicinc.cne.xml
CNE += com.quicinc.cneapiclient
CNE += CNEService
CNE += libcne
CNE += libcneapiclient
CNE += libcneconn
CNE += libcneqmiutils
CNE += libmasc
CNE += libNimsWrap
CNE += libvendorconn
CNE += libwqe
CNE += libxml
CNE += SwimConfig.xml

#QUICKCHARGE
QUICKCHARGE := hvdcp

#BT
BT := btnvtool
BT += dun-server
BT += hci_qcomm_init

#GPS
GPS := com.qualcomm.location

#SECUREMSM
SECUREMSM := qseecomd
SECUREMSM += libQSEEComAPI

#REMOTEFS
REMOTEFS := rmt_storage

PRODUCT_PACKAGES += $(QMI) 
PRODUCT_PACKAGES += $(PERMGR)
PRODUCT_PACKAGES += $(QCRiL)
PRODUCT_PACKAGES += $(DATA)
PRODUCT_PACKAGES += $(SYSTEM_HEALTH_MONITOR)
PRODUCT_PACKAGES += $(TIME_SERVICES)
PRODUCT_PACKAGES += $(THERMAL_ENGINE)
PRODUCT_PACKAGES += $(THERMAL_ENGINE)
PRODUCT_PACKAGES += $(QUICKBOOT)
PRODUCT_PACKAGES += $(CNE)
PRODUCT_PACKAGES += $(QUICKCHARGE)
PRODUCT_PACKAGES += $(BT)
PRODUCT_PACKAGES += $(GPS)
PRODUCT_PACKAGES += $(SECUREMSM)
PRODUCT_PACKAGES += $(REMOTEFS)
