extends Resource

class_name UpgradeInfo

export(Array, Tower.UPGRADE_TYPE) var type
export(Array, Array, Array, float) var data

# upgradeInfo has as many rows as there are upgrade types
# then each row has how many upgrades are available
# each upgrade has increaseAmmount and cost
