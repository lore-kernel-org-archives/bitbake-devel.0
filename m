Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGPcz-0005y1-Or
	for bitbake-devel@lists.openembedded.org;
	Sat, 07 Apr 2012 09:00:06 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 06 Apr 2012 23:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="86302105"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 06 Apr 2012 23:50:51 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Fri, 6 Apr 2012 23:50:50 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Sat, 7 Apr 2012 14:50:49 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Cui, Dexuan" <dexuan.cui@intel.com>, "Xu, Dongxiao"
	<dongxiao.xu@intel.com>, Saul Wold <sgw@linux.intel.com>, Paul Eggleton
	<paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] hob2: make xterm automatically exit after qemu
	exits?
Thread-Index: AQHNE06hUjLOPmvyikq06cBPZFSBjJaO7LUA
Date: Sat, 7 Apr 2012 06:50:48 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23B15B7F@SHSMSX102.ccr.corp.intel.com>
References: <A25F549E4D43CD42B4C02DF47A1913230FCFCD6A@SHSMSX102.ccr.corp.intel.com>
	<A25F549E4D43CD42B4C02DF47A1913230FCFCF0F@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <A25F549E4D43CD42B4C02DF47A1913230FCFCF0F@SHSMSX102.ccr.corp.intel.com>
Accept-Language: en-US
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
X-List-Received-Date: Sat, 07 Apr 2012 07:00:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Cui, Dexuan wrote on=A02012-04-06:

> Cui, Dexuan wrote on 2012-04-05:
>> Hi all, I'm testing hob2's "Run image" functionality and found the xterm
>> window doesn't exit automatically after the qemu exits.
>>=20
>> As a result, every time when I try "Run image", a new xterm window is
>> created. After some rounds of testing, I have to manually terminate
>> many windows one by one... Is this the intended behavior? If no, I
>> think we should remove the "; bash" from builder.py(see the grep result
>> at the end of the mail)?
Intended to be. Removing "bash" doesn't fix the problem. I tried that befor=
e.
We followed what ADT did. Lianhao told me when the user needs to launch qem=
u to debug in ADT Eclipse plugin, the ADT team uses xterm, since that is th=
e minimal terminal. So I didn't investigate other approaches but stood on t=
he shoulder of the ADT team.

I suspect that will occur on ADT's side. Jessica, Lianhao, do you have bett=
er solution?

>>=20
>> BTW, I think the hig.py (the deploy tool) has the same issue?
>>=20
>> $ grep "; bash" bitbake/ -nr bitbake/lib/bb/ui/crumbs/builder.py:937:
>> cmdline +=3D "runqemu " + kernel_path + " " + image_path + "; bash\""
>> bitbake/lib/bb/ui/crumbs/hig.py:741: cmdline +=3D "\"sudo dd if=3D" +
>> self.image_path + " of=3D" + combo_item + "; bash\""
Yes.

>=20
> A new question:
> Why do we use /usr/bin/xterm here by hardcode?
> Can we change it to matchbox-terminal? Or, can we use some kind of
> algorithm to determine the available terminal?
Is matchbox-terminal the minimal terminal on Linux distributions, compared =
with xterm? If so, we can replace xterm with that.
Yes, we can, feature enhancement.

>=20
> I asked the question because in the self-hosted-image of poky,
> we don't have xterm (poky doesn't have a recipe for xterm) and I
> think it may not deserve the effort to add a recipe for xterm only
> for this specific usage in self-hosted-image.
I see. My concern is whether matchbox-terminal is available on Ubuntu/Fedor=
a/OpenSuse/CentOS, and so on.

>=20
> Thanks,
> -- Dexuan
>




