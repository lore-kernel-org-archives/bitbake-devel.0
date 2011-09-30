Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]
	helo=AM1EHSOBE001.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1R9g9e-0006HN-Bn
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Sep 2011 18:41:43 +0200
Received: from mail19-am1-R.bigfish.com (10.3.201.247) by
	AM1EHSOBE001.bigfish.com (10.3.204.21) with Microsoft SMTP Server id
	14.1.225.22; Fri, 30 Sep 2011 16:21:04 +0000
Received: from mail19-am1 (localhost.localdomain [127.0.0.1])	by
	mail19-am1-R.bigfish.com (Postfix) with ESMTP id 402642F04B8;
	Fri, 30 Sep 2011 16:21:04 +0000 (UTC)
X-SpamScore: -17
X-BigFish: VS-17(zz9371K1803M1432N98dKzz1202hzz8275bh8275dhz2dh2a8h668h839h8e2h8e3h)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null);
	IPVD:NLI; H:mail.freescale.net; RD:none; EFVD:NLI
X-FB-SS: 0,
Received: from mail19-am1 (localhost.localdomain [127.0.0.1]) by mail19-am1
	(MessageSwitch) id 1317399639661688_25021;
	Fri, 30 Sep 2011 16:20:39 +0000 (UTC)
Received: from AM1EHSMHS001.bigfish.com (unknown [10.3.201.252])	by
	mail19-am1.bigfish.com (Postfix) with ESMTP id 97A3313B0062;
	Fri, 30 Sep 2011 16:20:39 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS001.bigfish.com
	(10.3.207.101) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Fri, 30 Sep 2011 16:20:38 +0000
Received: from 039-SN1MPN1-003.039d.mgd.msft.net ([169.254.3.230]) by
	039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id
	14.01.0323.007; Fri, 30 Sep 2011 11:20:37 -0500
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Yu Ke <ke.yu@intel.com>
Thread-Topic: [bitbake-devel] Feedback on HOB (new image creator GUI)
Thread-Index: AQHMf4ziodQj6EIfBk2AFipaRDmOxg==
Date: Fri, 30 Sep 2011 16:20:36 +0000
Message-ID: <CAEsOVNdwudRO7V2DQhpESC=xCqDtJqxJ72+e_hYDLq7bE=z+cg@mail.gmail.com>
References: <4E85D3E0.7070807@intel.com>
In-Reply-To: <4E85D3E0.7070807@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-Mailman-Approved-At: Fri, 30 Sep 2011 23:43:27 +0200
Cc: "joshua.lock@intel.com" <joshua.lock@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: Feedback on HOB (new image creator GUI)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 30 Sep 2011 16:41:43 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EB1F4B4F878AAE43B6BFB62D25A48CA0@freescale.net>
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2011 at 9:36 AM, Yu Ke <ke.yu@intel.com> wrote:
> Hi,
>
> As you may already know, a new GUI has been added to bitbake recently, i.=
e.
> HOB (Human Oriented Builder). It is a graphical image creator that allows
> user to freely choose which packages to be built in the image. The wiki
> https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob =A0has more detail.
>
> This email is to collect your feedback on the HOB. Current HOB is our fir=
st
> version, and it surely has many place to improve. We has the plan to enha=
nce
> it in Yocto 1.2. So we really hope that you can use it and provide your
> valuable feedback . We do think user's feedback/requirement is the right =
way
> to go. Looking forward your valuable input.
>
> Best Regards
> Ke
>
> Ps. The simple way to run hob is:
> # touch conf/hob-pre.conf conf/hob-post.conf
> # bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf
>
> Where conf/hob-pre.conf conf/hob-post.conf is the configuration file, whi=
ch
> can be empty in above case.

Has any discussion gone into making some sort of plugin or extensions?
I'd like for it to be as easy as possible for someone new to make hob
be able to some things like: configure runtime services, configure
networking settings, add users, and I'm sure there are other things.

-M=



