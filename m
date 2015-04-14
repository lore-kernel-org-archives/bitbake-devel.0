Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A252D73912
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Apr 2015 21:19:07 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 14 Apr 2015 14:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,578,1422950400"; d="scan'208";a="680103563"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
	by orsmga001.jf.intel.com with ESMTP; 14 Apr 2015 14:19:09 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.47]) by
	ORSMSX110.amr.corp.intel.com ([10.22.240.8]) with mapi id
	14.03.0224.002; Tue, 14 Apr 2015 14:19:07 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: Ed Bartosh <ed.bartosh@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] Allow environment variables and ~ in bbconf paths
Thread-Index: AQHQdvQJ96Bddj2LekG9zzc4/u+sNp1NA0SA
Date: Tue, 14 Apr 2015 21:19:07 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237988ED7477@ORSMSX101.amr.corp.intel.com>
References: <1429044350-19766-1-git-send-email-ed.bartosh@linux.intel.com>
In-Reply-To: <1429044350-19766-1-git-send-email-ed.bartosh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH] Allow environment variables and ~ in bbconf paths
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
X-List-Received-Date: Tue, 14 Apr 2015 21:19:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ed,=20

This worked for me.... Thanks.

Scott

>-----Original Message-----
>From: Ed Bartosh [mailto:ed.bartosh@linux.intel.com]
>Sent: Tuesday, April 14, 2015 1:46 PM
>To: bitbake-devel@lists.openembedded.org
>Cc: Rifenbark, Scott M; Ed Bartosh
>Subject: [PATCH] Allow environment variables and ~ in bbconf paths
>
>This should allow to use ~, $HOME and other environment variables in bbcon=
f
>paths.
>
>Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
>---
> bitbake/lib/bb/cookerdata.py | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
>index 6c11a60..ec5c9ea 100644
>--- a/bitbake/lib/bb/cookerdata.py
>+++ b/bitbake/lib/bb/cookerdata.py
>@@ -271,6 +271,7 @@ class CookerDataBuilder(object):
>             data =3D bb.data.createCopy(data)
>             for layer in layers:
>                 parselog.debug(2, "Adding layer %s", layer)
>+                layer =3D os.path.expanduser(os.path.expandvars(layer))
>                 data.setVar('LAYERDIR', layer)
>                 data =3D parse_config_file(os.path.join(layer, "conf", "l=
ayer.conf"),
>data)
>                 data.expandVarref('LAYERDIR')
>--
>2.1.4


