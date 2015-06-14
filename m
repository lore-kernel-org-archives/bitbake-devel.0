Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 7F51C758D3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Jun 2015 21:44:00 +0000 (UTC)
Received: by wigg3 with SMTP id g3so59626547wig.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Jun 2015 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to:cc
	:message-id; bh=zTSmAN+N0xwMsgz/1W2JUPF+HGzIgH3yVsMTEjJW9VA=;
	b=Od+2betY50ww5EEjzUnHQOLyshRHwFnO1ZN8lKPaFSh0cRBmSGN/e2lAfxiWLFSpW4
	r69wu8POq8AT6CgUBADx5Orb/LklMBqcc5nFMJQSgPBGy8aeotjQUpSu4SSfUSNdR87D
	V+mairV3A/am5ca4AT8N5toqMdQsKkZitw3S6qK+4mIeIYanu4jmZ8aUfAuolVrGZtHX
	WBZN9Gu0iFOXEXbSy3lFp43a4+1///qE916CtJqtf+pmpaGmmuwt/JsFx8DmBJlckE7M
	HKaymXj+yb9HkTHQPvl4Fc84ihf23kIo8dyTwkGntSU7bA5hj5JOwS+a3XpO6L1gvA2H
	79FA==
X-Received: by 10.180.86.168 with SMTP id q8mr25076737wiz.80.1434318239345;
	Sun, 14 Jun 2015 14:43:59 -0700 (PDT)
Received: from android-5344fe5e44c2fa60.weghof
	(195-230-55-189.adsl.highway.telekom.at. [195.230.55.189])
	by mx.google.com with ESMTPSA id r9sm16032629wjo.26.2015.06.14.14.43.57
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 14 Jun 2015 14:43:58 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CABcZANnmPX=wU8BNt+y3UnCLOkbB9LWR-Lwgw6zVxa-_+PF6kQ@mail.gmail.com>
References: <355BE46A91031048906B695426A8D8E616BEA6C0@DEFTHW99EH4MSX.ww902.siemens.net>
	<CABcZANnmPX=wU8BNt+y3UnCLOkbB9LWR-Lwgw6zVxa-_+PF6kQ@mail.gmail.com>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Sun, 14 Jun 2015 23:43:54 +0200
To: Christopher Larson <clarson@kergoth.com>, "Bach,
	Pascal" <pascal.bach@siemens.com>
Message-ID: <FDD27E4D-9B52-49FA-A99A-076F615C3A5D@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Allow access to specific git server while BB_FETCH_PREMIRRORONLY ="1"
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
X-List-Received-Date: Sun, 14 Jun 2015 21:44:05 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

On June 12, 2015 3:04:17 PM GMT+02:00, Christopher Larson <clarson@kergoth.com> wrote:
>On Fri, Jun 12, 2015 at 7:47 AM, Bach, Pascal <pascal.bach@siemens.com>
>wrote:
>
>> I was wondering if there is a way to allow access to specific urls
>even if
>> BB_NO_NETWORK or BB_FETCH_PREMIRRORONLY is set.
>>
>> The use case I have at hand it that we want to fetch all 3rd party
>sources
>> from a HTTP premirror we have internally. Except for some packages
>that
>> are hosted on a git server where we would like bitbake to always
>fetch from
>> there (no tarball on the pre mirror).
>>
>> I tried:
>> PREMIRROR_prepend = "git@local/foo.git git@local/foo.git \n"
>>
>>
>> But this doesn't seem to work.
>>
>> Is there way to achieve this with the current PREMIRROR variable? Or
>is
>> this functionality currently missing?
>>
>
>See the recently added BB_TRUSTED_NETWORK variable.

I hope the v3 with BB_ALLOWED_NETWORKS was applied instead but cannot currently check.

TIA,



