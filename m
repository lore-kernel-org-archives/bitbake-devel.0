Return-Path: <dl9pf@gmx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0D3C4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 10:01:01 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by mx.groups.io with SMTP id smtpd.web10.14567.1713780052921860210
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Apr 2024 03:00:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=dl9pf@gmx.de header.s=s31663417 header.b=ekC+AeVx;
 spf=pass (domain: gmx.de, ip: 212.227.15.19, mailfrom: dl9pf@gmx.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713780050; x=1714384850; i=dl9pf@gmx.de;
	bh=nDDffq3vUAzPh8UoGv8DLxZN+wpTmgILs2WnZW5zl4U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ekC+AeVx2dzoddLKNxzY/Xnc3fVlmyi+crgaop27KP3PbPMhVwnKtIetWmbzEMiS
	 /hrdkYtvi3rk0OeXyYIZmKjKNYS4h0BxjO9nGl64xEV+UPxZnqgMjvw+r3aQ7OrVM
	 y13VdLuI3Idq46QPphlWxNYsOlJcO/pJWKwSoM/rMA6dcoLK6LVEO1+jsID2kBtHI
	 wXp5gCHpASTlgjMXOxuJYEqcQvGaQyzr0JqSa+OdRJwX60pR51/3ij2BmG+7VBzSM
	 4sxnotzOa/aj8+Pko1Cimg6qOx52bpQ+aATVqU+azx26cvuHLfczIM0jIFHtM8nL4
	 h+Svj93r4QTpsbVhKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arbeit.localnet ([77.23.168.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2W5-1sNyAI3awZ-00k7k0; Mon, 22
 Apr 2024 12:00:49 +0200
From: Jan-Simon =?ISO-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>,
 JPEWhacker@gmail.com, jsmoeller@linuxfoundation.org, dl9pf@gmx.de
Subject: 
 Re: [bitbake-devel] bitbake-selftest losing sqlite3 database contents!
Date: Mon, 22 Apr 2024 12:00:43 +0200
Message-ID: <10108676.tdPhlSkOF2@arbeit>
In-Reply-To: 
 <CAJdd5GZYDtvvhkKKD4jukbWDatiWPXxQTwsjh+6HcFji+wNCHg@mail.gmail.com>
References: 
 <d85e68b3-18ec-428e-b17a-b012bc9e2c75@bootlin.com>
 <7ca8f12c-fd13-4e60-ab4e-7016e2f9a683@bootlin.com>
 <CAJdd5GZYDtvvhkKKD4jukbWDatiWPXxQTwsjh+6HcFji+wNCHg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:4PK8elgL2+PGoREutZw5YG80qNERtfQXdWr34M9sKV91650gtik
 leI2AaL6xXhxii7QNnK0JjcwgiZxMZmL691AsNk4xr7/zzunJ4Q6eGnaN4BC30F1EHhcTjL
 k3OEdFV+2rDceJ7E5t8YHTLteCGdTYJ0+zQ8reFL8tyE8XHPkeyOtpSY+CSE6GSd29Hunhj
 co7KaLfgMHfy5c6utPS7g==
UI-OutboundReport: notjunk:1;M01:P0:YS6vrBoOtPo=;xF+adVNTHsIJNah2S1wlWrBGmg9
 ts++8NixxBIoXMdLYfXRjVVNX7XaOXO2xhXQ6epqrDZplReBM76NQOEhnrh7OroPGY2Mj7E0f
 utTZ9s2jAlEQUPGZTHIxiuWV2ty2JHoVqLX8h0H/sh4ARoZ9RmcUb8ekkIrvxLFwWjd+4dzIu
 AX+gBLP6fQnDjf717SuG8T48p+hA5VKIRmbj/RfJRznp62h1TnrwSsaR0xiGoeo+J3xaQbRO7
 lKXQwae84j8NXZrcDC3WSqc6SOuDJwD5SRNkcehPA6H30MMC+0CvXnYrmRq41fo4iYGL6sipI
 GIjEnHunA2DeLyqjBfsZtm4l5eY/jEN0zvL1Tk2XdvhYbTxWDqmtht1FI+xVgEw4BSjSRVwn+
 57DfwoHV4Ls5K2soeU77v9QgsUgHS14dPFtLephCsQTSsAMxrsVaY6C8DJEVt5K07Pvnot4V5
 XiPw70Xd9YA9Ud/lguEvTM2Uy6pvI27Ooh9Q7lfJFoOMU60NDwdH9A1/ni5BE6maDIA0tqRFS
 00jh8iqQgNnZPr1Iu0BN8iZMFyGKKE196iIcmirNMcrNfmjN/SzXJ1RzRqNsxPyLtg5PzTirB
 pzWdFb9jFyrBPiWBq5+lOGgV4frXzTx1TXkwf8nRHiFi7VgsyYGJlq1iA+1u3e6VtfCUT4oKl
 MurGd6Gqt+NjGJHTFGDkPu677piKRp12wjSS4CKiWorn3j6MlbodqWiBC1sNcq6W9LU3xBBgv
 c11sBeLPf4982nWpM0lX8vpzdXfjrlhrwboUGgjSEXpc+yGzr5cZPNcEg+iKlt9UqZe5V7BFh
 7Uj/YdhA/5xWcD/BEeuwVq3RJ6Vie2pFbexhV0PAwLF5Q=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Apr 2024 10:01:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16119

Am Samstag, 20. April 2024, 22:35:33 CEST schrieb Joshua Watt via lists.op=
enembedded.org:

> I'm not exactly sure what the purpose of the read-only prserv is in
> the first place; based on these requirements, it sort of sounds like
> there isn't anyway to make a read-only server that has actual data in
> it :)

Well what about this use-case:
An CI loop would populate using a rw PR-server , those artifacts (sources,=
 sstate, hashserv(!), deploy dir)
are then pushed to a download server. We do not want to expose that r/w PR=
-serv publically.
Now for a binary feed-like setup, we'd need a matching PR and Hashserv for=
 the downstream. No ?
Thus extra r/o instances sharing the same sqlite in the back.
Isn't this then required for a downstream user to create their own 'matchi=
ng' binaries for the feed ?

Correct me, but e.g. this is what we assume is the way to expose the data:

# rw prserv on port 8181
bitbake-prserv --start --file /home/yocto/pr_hash_serv-volume/prserv.db --=
loglevel=3DDEBUG --log /home/yocto/pr_hash_serv-volume/prserv-rw.log --por=
t 8181
# ro prserv on port 8282
bitbake-prserv --start -r --file /home/yocto/pr_hash_serv-volume/prserv.db=
 --loglevel=3DDEBUG --log /home/yocto/pr_hash_serv-volume/prserv-ro.log --=
port 8282

# rw hashserv on port 8383
bitbake-hashserv --bind :8383 --log DEBUG --database /home/yocto/pr_hash_s=
erv-volume/hashserv.db > /home/yocto/pr_hash_serv-volume/hashserv-rw.log 2=
>&1 &
# ro hashserv on port 8484
bitbake-hashserv -r --bind :8484 --log DEBUG --database /home/yocto/pr_has=
h_serv-volume/hashserv.db > /home/yocto/pr_hash_serv-volume/hashserv-ro.lo=
g 2>&1 &


@Richard/Josh:
Let me add (yes, grumble a bit ;) ) : for me as *end user* of this, this i=
s all the same and would be best kept in one single server that I can scal=
e.
Having it split into two just complicates things ... and now for scarthgap=
, we need another instance of the hashserv due to the API change.
Please consider this from a user perspective working on multiple branches =
and not just one master branch!
The data might not be 'the same' or not 'connected', but they are still li=
nked in a way and moreover we are exposing this to users
to use and usage gets mandatory if we think of speeding up builds and bina=
ry feeds. Don't get me wrong, this is good stuff, but we make it hard for =
general use.
Wrt scaling: - essentially we're setting us up with scaling problems wrt p=
rserv down the road when it gets needed for binary feed.
Heck, we're just solving this for hashserv, so why not do this likewise ri=
ght away - at best put both in one server?

@Michael: the 'empty file' issue rings a bell and I've seen this back when=
 we tried this for the first time.
Export did not work either. But I have a hard time remembering the details=
. Might even depend on sqlite versions back then.
I found this in my local git:
sed -i -e "s#EXCLUSIVE#IMMEDIATE#g" /home/yocto/poky/bitbake/lib/prserv/db=
.py
It probably helped some but might cause other issues. Let's see what the e=
xperts say.


> Ostensibly, you should be able to write a test fixture that does
> whatever a real-life PR server installation would do to populate a
> database and then make it read-only. You would then do this process on
> the test database before each test where you needed to test the read
> only functionality. You have to do it for each test because as you
> noticed, you should not ever have "carry-over" in state from one test
> to another. Having carry-over between tests is not a good idea for a
> lot of reasons, which is why the hash server tests are setup the way
> that they are with an empty database for each test.

I second Josh here.


Best,
JS





