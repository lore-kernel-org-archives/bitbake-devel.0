Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1SFqK1-0007pm-75
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 19:18:09 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 05 Apr 2012 10:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="127541743"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 05 Apr 2012 10:07:53 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 5 Apr 2012 10:07:52 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Fri, 6 Apr 2012 01:07:50 +0800
From: "Cui, Dexuan" <dexuan.cui@intel.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>, "Wang, Shane"
	<shane.wang@intel.com>, Saul Wold <sgw@linux.intel.com>, Paul Eggleton
	<paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] hob2: make xterm automatically exit after qemu
	exits?
Thread-Index: AQHNE06hWB2oO3ZpP0OwtJ6vTYU/uA==
Date: Thu, 5 Apr 2012 17:07:49 +0000
Message-ID: <A25F549E4D43CD42B4C02DF47A1913230FCFCF0F@SHSMSX102.ccr.corp.intel.com>
References: <A25F549E4D43CD42B4C02DF47A1913230FCFCD6A@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <A25F549E4D43CD42B4C02DF47A1913230FCFCD6A@SHSMSX102.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: hob2: make xterm automatically exit after qemu	exits?
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
X-List-Received-Date: Thu, 05 Apr 2012 17:18:09 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Cui, Dexuan wrote on 2012-04-05:
> Hi all, I'm testing hob2's "Run image" functionality and found the xterm
> window doesn't exit automatically after the qemu exits.
>=20
> As a result, every time when I try "Run image", a new xterm window is cre=
ated.
> After some rounds of testing, I have to manually terminate many windows o=
ne
> by one... Is this the intended behavior? If no, I think we should remove =
the ";
> bash" from builder.py(see the grep result at the end of the mail)?
>=20
> BTW, I think the hig.py (the deploy tool) has the same issue?
>=20
> $ grep "; bash" bitbake/ -nr
> bitbake/lib/bb/ui/crumbs/builder.py:937: cmdline +=3D "runqemu " + kernel=
_path
> + " " + image_path + "; bash\""
> bitbake/lib/bb/ui/crumbs/hig.py:741: cmdline +=3D "\"sudo dd if=3D" +
> self.image_path + " of=3D" + combo_item + "; bash\""

A new question:
Why do we use /usr/bin/xterm here by hardcode?=20
Can we change it to matchbox-terminal? Or, can we use some kind of
algorithm to determine the available terminal?

I asked the question because in the self-hosted-image of poky,
we don't have xterm (poky doesn't have a recipe for xterm) and I
think it may not deserve the effort to add a recipe for xterm only
for this specific usage in self-hosted-image.

Thanks,
-- Dexuan




