Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 818386B10E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2013 10:37:53 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 17 Jul 2013 03:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,683,1367996400"; d="scan'208";a="269411068"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
	by AZSMGA002.ch.intel.com with ESMTP; 17 Jul 2013 03:37:53 -0700
Received: from irsmsx151.ger.corp.intel.com (163.33.192.59) by
	IRSMSX104.ger.corp.intel.com (163.33.3.159) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Wed, 17 Jul 2013 11:37:12 +0100
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.52]) by
	IRSMSX151.ger.corp.intel.com ([169.254.4.214]) with mapi id
	14.03.0123.003; Wed, 17 Jul 2013 11:37:11 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 00/14] bitbake+hob: templates enhancement
Thread-Index: AQHOgtkXNMUYXbTRi0OdMXxviTyf45lorUPg
Date: Wed, 17 Jul 2013 10:37:10 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7EBD56@IRSMSX105.ger.corp.intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
In-Reply-To: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
Subject: Re: [PATCH 00/14] bitbake+hob: templates enhancement
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 17 Jul 2013 10:37:54 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

If you want to test this functionality, there is a poky-contrib branch with=
 these patches:
http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dcvoicu/hobt=
emplates

Thanks,
Cristiana

-----Original Message-----
From: Voicu, Cristiana=20
Sent: Wednesday, July 17, 2013 1:36 PM
To: bitbake-devel@lists.openembedded.org
Cc: Voicu, Cristiana
Subject: [PATCH 00/14] bitbake+hob: templates enhancement

This set implements the templates functionality in Hob.
There are two new files, with two different dialogs.
The changes are in bitbake and Hob.

Cristiana Voicu (14):
  hob: labelling changes in Hob
  hob: create save image dialog used to save a template
  hob/bitbake: create a template (a .bb file) from hob through bitbake
  hob/bitbake: save the description of a custom image
  hob: make changes in order to permit from UI to edit an image after
    saving it
  hob & bitbake: append a value to a variable from hob throught bitbake
  hob: change the name and description for the saveimagedialog
  hob: the saved image should be editable
  bitbake: when an image is saved, it should require an image from
    layers
  hob: changes to image combo box
  hob: retrieve file name of an image
  hob: implement the "retrieve image dialog" + changes to image combo
    box
  bitbake: save packages in IMAGE_INSTALL instead of PACKAGE_INSTALL
  hob: set focus on entry name when the name is not correct

 bitbake/lib/bb/command.py                          |   12 +-
 bitbake/lib/bb/cooker.py                           |   75 ++++++++--
 bitbake/lib/bb/data.py                             |    4 +
 bitbake/lib/bb/ui/crumbs/builder.py                |   15 ++
 .../lib/bb/ui/crumbs/hig/retrieveimagedialog.py    |   49 +++++++
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py    |  151 ++++++++++++++++=
++++
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   29 +++-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   40 ++++--
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   70 +++++++--
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |   37 ++++-
 10 files changed, 438 insertions(+), 44 deletions(-)  create mode 100644 b=
itbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py

--
1.7.9.5


