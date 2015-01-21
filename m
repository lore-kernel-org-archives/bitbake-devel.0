Return-Path: <Chong.Lu@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 661DB6AD01
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 08:07:28 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0L87T89006838
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 00:07:29 -0800 (PST)
Received: from pek-hostel-deb02.wrs.com (128.224.153.152) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.174.1; Wed, 21 Jan 2015 00:07:28 -0800
From: Chong Lu <Chong.Lu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Jan 2015 16:02:48 +0800
Message-ID: <cover.1421827025.git.Chong.Lu@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH 0/2] bitbake-layers: add a ability to query layer dependencies from layer index
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 21 Jan 2015 08:07:31 -0000
Content-Type: text/plain

$ bitbake-layers show-layer-deps errorlayer,meta-openstack
Parsing recipes..done.
Layer                 Dependencies          Git repository                                           Subdirectory
===================================================================================================================
meta-openstack        meta-ruby             git://git.openembedded.org/meta-openembedded             meta-ruby
meta-openstack        meta-networking       git://git.openembedded.org/meta-openembedded             meta-networking
meta-openstack        meta-virtualization   git://git.yoctoproject.org/meta-virtualization           
meta-openstack        openembedded-core     git://git.openembedded.org/openembedded-core             meta
meta-openstack        meta-oe               git://git.openembedded.org/meta-openembedded             meta-oe
WARNING: errorlayer is not found in layer index.
Cloning into '/buildarea2/clu1/source/poky/meta-cloud-services'...
Add "meta-openstack" to conf/bblayers.conf
Cloning into '/buildarea2/clu1/source/poky/meta-openembedded'...
Add "meta-ruby" to conf/bblayers.conf
Add "meta-networking" to conf/bblayers.conf
Cloning into '/buildarea2/clu1/source/poky/meta-virtualization'...
Add "meta-virtualization" to conf/bblayers.conf
Add "meta-oe" to conf/bblayers.conf

$ cat conf/bblayers.conf 
# LAYER_CONF_VERSION is increased each time build/conf/bblayers.conf
# changes incompatibly
LCONF_VERSION = "6"

BBPATH = "${TOPDIR}"
BBFILES ?= ""

BBLAYERS ?= " \
  /buildarea2/clu1/source/poky/meta \
  /buildarea2/clu1/source/poky/meta-yocto \
  /buildarea2/clu1/source/poky/meta-yocto-bsp \
  /buildarea2/clu1/source/poky/meta-cloud-services/meta-openstack \
  /buildarea2/clu1/source/poky/meta-openembedded/meta-ruby \
  /buildarea2/clu1/source/poky/meta-openembedded/meta-networking \
  /buildarea2/clu1/source/poky/meta-virtualization \
  /buildarea2/clu1/source/poky/meta-openembedded/meta-oe \
  "

The following changes since commit 35c9fa0588ed8e88b541a6c80cc1517324616cea:

  maintainers: Update for non-maintained recipes (2015-01-20 21:39:41 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib chonglu/layerindex
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=chonglu/layerindex

Chong Lu (2):
  bitbake.conf: Add two variables for layer index
  bitbake-layers: add a ability to query layer dependencies from layer
    index

 bitbake/bin/bitbake-layers | 174 +++++++++++++++++++++++++++++++++++++++++++++
 meta/conf/bitbake.conf     |   6 ++
 2 files changed, 180 insertions(+)

-- 
1.9.1


