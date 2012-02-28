Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]
	helo=ch1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1S2Qa4-0008Je-HR
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 18:11:16 +0100
Received: from mail181-ch1-R.bigfish.com (10.43.68.236) by
	CH1EHSOBE012.bigfish.com (10.43.70.62) with Microsoft SMTP Server id
	14.1.225.23; Tue, 28 Feb 2012 16:32:35 +0000
Received: from mail181-ch1 (localhost [127.0.0.1])	by
	mail181-ch1-R.bigfish.com (Postfix) with ESMTP id 04AEA140449;
	Tue, 28 Feb 2012 16:32:35 +0000 (UTC)
X-SpamScore: -7
X-BigFish: VS-7(zz9371I1432N98dKzz1202hzz8275bhz2dh2a8h668h839h8e2h8e3hbe9k)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail181-ch1 (localhost.localdomain [127.0.0.1]) by mail181-ch1
	(MessageSwitch) id 1330446752558320_22710;
	Tue, 28 Feb 2012 16:32:32 +0000 (UTC)
Received: from CH1EHSMHS010.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.253])	by mail181-ch1.bigfish.com (Postfix) with ESMTP id
	81B88120053;	Tue, 28 Feb 2012 16:32:32 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS010.bigfish.com
	(10.43.70.10) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Tue, 28 Feb 2012 16:32:31 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.244]) by
	039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id
	14.01.0355.003; Tue, 28 Feb 2012 10:32:30 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake: fix setscene task
	start/failure handling
Thread-Index: AQHM9YQ113qTCnYFEk+/Pa8IM5XjnJZRzWeAgAEZLAA=
Date: Tue, 28 Feb 2012 16:32:29 +0000
Message-ID: <CAEsOVNcu_viCVVsoO9jg-eB9bA8GYBs33B4_7KYidqyuh9Ft8w@mail.gmail.com>
References: <cover.1330368761.git.paul.eggleton@linux.intel.com>
	<67b6b60673a682f1d76aa224e0e47e1ca83f5bc9.1330368761.git.paul.eggleton@linux.intel.com>
	<CAEsOVNdC8Xh4E32Lep8g0BjNXFQHJzGVZ3s3gTied6UYqNnCYA@mail.gmail.com>
	<2548258.gq2qYr9CFK@helios>
In-Reply-To: <2548258.gq2qYr9CFK@helios>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
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
X-List-Received-Date: Tue, 28 Feb 2012 17:11:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <13EEC7FA172DBB4FA39BCB38E9B3CDEB@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2012 at 5:45 PM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> On Monday 27 February 2012 19:15:46 McClintock Matthew-B29882 wrote:
>> On Mon, Feb 27, 2012 at 12:54 PM, Paul Eggleton
>>
>> <paul.eggleton@linux.intel.com> wrote:
>> > + =A0 =A0 =A0 =A0 =A0 =A0if isinstance(event, bb.runqueue.sceneQueueTa=
skFailed):
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0logger.warn("Setscene task %s (%s) fa=
iled with exit code
>> > '%s' - real task will be run instead", +
>> > event.taskid, event.taskstring, event.exitcode)
>> This removes the "ERROR:" message, right?
>
> If a failure logs an ERROR itself then no, this would still be printed.
> However, in the case of an error situation such as one I simulated (unabl=
e to
> read from the sstate-cache file) nothing was being printed at all, which =
is not
> particularly helpful. Thus this part of the change.

I was referring to when the setscene tasks fails and we emit an ERROR
when it's not really a fatal error as we can just rerun the real task.
It's still an "issue" - but when I check my build logs for issues I
grep for ERROR and I'd rather leave ERROR for FATAL ERRORS.

Just my 2 cents.

-M=



