Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1SFolZ-00066e-Hv
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 17:38:29 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Apr 2012 08:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85703773"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Apr 2012 08:28:10 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 5 Apr 2012 08:28:10 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Thu, 5 Apr 2012 23:28:08 +0800
From: "Cui, Dexuan" <dexuan.cui@intel.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>, "Wang, Shane"
	<shane.wang@intel.com>
Thread-Topic: hob2: make xterm automatically exit after qemu exits?
Thread-Index: Ac0TQLQN5PLdWqBrSRKp9XcvN3c91A==
Date: Thu, 5 Apr 2012 15:28:08 +0000
Message-ID: <A25F549E4D43CD42B4C02DF47A1913230FCFCD6A@SHSMSX102.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: hob2: make xterm automatically exit after qemu exits?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 05 Apr 2012 15:38:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all, I'm testing hob2's "Run image" functionality and found the xterm wi=
ndow doesn't exit automatically after the qemu exits.

As a result, every time when I try "Run image", a new xterm window is creat=
ed. After some rounds of testing, I have to manually terminate many windows=
 one by one... Is this the intended behavior? If no, I think we should remo=
ve the "; bash" from builder.py(see the grep result at the end of the mail)=
?

BTW, I think the hig.py (the deploy tool) has the same issue?

$ grep "; bash" bitbake/ -nr
bitbake/lib/bb/ui/crumbs/builder.py:937: cmdline +=3D "runqemu " + kernel_p=
ath + " " + image_path + "; bash\""
bitbake/lib/bb/ui/crumbs/hig.py:741: cmdline +=3D "\"sudo dd if=3D" + self.=
image_path + " of=3D" + combo_item + "; bash\""

Thanks,
-- Dexuan



