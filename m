Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]
	helo=DB3EHSOBE006.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RlijK-00034v-40
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 16:07:46 +0100
Received: from mail9-db3-R.bigfish.com (10.3.81.241) by
	DB3EHSOBE006.bigfish.com (10.3.84.26) with Microsoft SMTP Server id
	14.1.225.23; Fri, 13 Jan 2012 14:45:04 +0000
Received: from mail9-db3 (localhost [127.0.0.1])	by mail9-db3-R.bigfish.com
	(Postfix) with ESMTP id 27BAC6A008B;
	Fri, 13 Jan 2012 14:45:04 +0000 (UTC)
X-SpamScore: -10
X-BigFish: VS-10(zz9371I936eK1432N98dKzz1202hzz8275bh8275dhz2dhc1ahc1bh2a8h668h839h8e2h8e3hbe9k)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-FB-SS: 13,
Received: from mail9-db3 (localhost.localdomain [127.0.0.1]) by mail9-db3
	(MessageSwitch) id 132646590418283_12518;
	Fri, 13 Jan 2012 14:45:04 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.246])	by
	mail9-db3.bigfish.com (Postfix) with ESMTP id E73EE1A0053;
	Fri, 13 Jan 2012 14:45:03 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by DB3EHSMHS011.bigfish.com
	(10.3.87.111) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Fri, 13 Jan 2012 14:44:57 +0000
Received: from 039-SN1MPN1-002.039d.mgd.msft.net ([169.254.2.86]) by
	039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id
	14.01.0355.003; Fri, 13 Jan 2012 08:44:56 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake/fetch2: add support for
	wrapper command
Thread-Index: AQHM0c+eMqAYB8S+20OSO2Wm19jd+pYKxK4A
Date: Fri, 13 Jan 2012 14:44:55 +0000
Message-ID: <CAEsOVNde_RCuzm3ehgmK+-iraRTpVrpW6N2EGyxRUW52yTdyoQ@mail.gmail.com>
References: <1326409741-17390-1-git-send-email-msm@freescale.com>
	<1326444277.11214.25.camel@ted>
In-Reply-To: <1326444277.11214.25.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake/fetch2: add support for wrapper command
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
X-List-Received-Date: Fri, 13 Jan 2012 15:07:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4DF8645DB1EEB244A6186ABBF707601C@freescale.net>
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2012 at 2:44 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Thu, 2012-01-12 at 17:09 -0600, Matthew McClintock wrote:
>> cc: bitbake-devel@lists.openembedded.org
>> Signed-off-by: Matthew McClintock <msm@freescale.com>
>> ---
>> =A0lib/bb/fetch2/__init__.py | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 3af56e5..1d7d5c7 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -389,6 +389,8 @@ def runfetchcmd(cmd, d, quiet =3D False, cleanup =3D=
 []):
>> =A0 =A0 =A0Optionally remove the files/directories listed in cleanup upo=
n failure
>> =A0 =A0 =A0"""
>>
>> + =A0 =A0cmd =3D "%s %s" % (bb.data.getVar("BB_FETCH_WRAPPER", d, True),=
 cmd)
>> +
>> =A0 =A0 =A0# Need to export PATH as binary could be in metadata paths
>> =A0 =A0 =A0# rather than host provided
>> =A0 =A0 =A0# Also include some other variables.
>
> Er, this is going to break for anyone who doesn't have BB_FETCH_WRAPPER
> set. It would be nice to document why you require this in the commit
> message (I can guess). Since I'm rejecting this patch, can the next one
> document the new variable in the fetcher section of bitbake manual too
> please? :)

Sorry, was looking for feedback too - I think I need to do:

cmd =3D "%s %s" % (bb.data.getVar("BB_FETCH_WRAPPER", d, True) or "", cmd)

I wrote a small blurb about why it was needed on the patch to oe-core,
we are trying to do CVS or a SOCKS5 proxy that has authentication (the
proxy) - I didn't see another way around this...

-M=



