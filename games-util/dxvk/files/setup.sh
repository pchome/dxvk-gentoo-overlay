#!/bin/bash

export WINETRICKS_LATEST_VERSION_CHECK=disabled

winetricks --force @verb_location@/setup_dxvk_winelib.verb
