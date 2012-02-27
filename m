Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]
	helo=TX2EHSOBE002.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1S26Pt-0002ne-4b
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 20:39:25 +0100
Received: from mail140-tx2-R.bigfish.com (10.9.14.247) by
	TX2EHSOBE002.bigfish.com (10.9.40.22) with Microsoft SMTP Server id
	14.1.225.23; Mon, 27 Feb 2012 19:15:51 +0000
Received: from mail140-tx2 (localhost [127.0.0.1])	by
	mail140-tx2-R.bigfish.com (Postfix) with ESMTP id 03690C0451;
	Mon, 27 Feb 2012 19:15:51 +0000 (UTC)
X-SpamScore: -1
X-BigFish: VS-1(zz9371I98dKzz1202hzz8275bhz2dh2a8h668h839h8e2h8e3hbe9k)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail140-tx2 (localhost.localdomain [127.0.0.1]) by mail140-tx2
	(MessageSwitch) id 1330370149161639_9795;
	Mon, 27 Feb 2012 19:15:49 +0000 (UTC)
Received: from TX2EHSMHS020.bigfish.com (unknown [10.9.14.246])	by
	mail140-tx2.bigfish.com (Postfix) with ESMTP id 22AB31A004A;
	Mon, 27 Feb 2012 19:15:49 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by TX2EHSMHS020.bigfish.com
	(10.9.99.120) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Mon, 27 Feb 2012 19:15:46 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.244]) by
	039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id
	14.01.0355.003; Mon, 27 Feb 2012 13:15:46 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake: fix setscene task
	start/failure handling
Thread-Index: AQHM9YQ113qTCnYFEk+/Pa8IM5XjnA==
Date: Mon, 27 Feb 2012 19:15:46 +0000
Message-ID: <CAEsOVNdC8Xh4E32Lep8g0BjNXFQHJzGVZ3s3gTied6UYqNnCYA@mail.gmail.com>
References: <cover.1330368761.git.paul.eggleton@linux.intel.com>
	<67b6b60673a682f1d76aa224e0e47e1ca83f5bc9.1330368761.git.paul.eggleton@linux.intel.com>
In-Reply-To: <67b6b60673a682f1d76aa224e0e47e1ca83f5bc9.1330368761.git.paul.eggleton@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] bitbake: fix setscene task start/failure handling
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
X-List-Received-Date: Mon, 27 Feb 2012 19:39:25 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D65C2CC43285DF4DAC53FCDCAB039CA1@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2012 at 12:54 PM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> + =A0 =A0 =A0 =A0 =A0 =A0if isinstance(event, bb.runqueue.sceneQueueTaskF=
ailed):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0logger.warn("Setscene task %s (%s) faile=
d with exit code '%s' - real task will be run instead",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 event.taskid, e=
vent.taskstring, event.exitcode)

This removes the "ERROR:" message, right?

-M=



