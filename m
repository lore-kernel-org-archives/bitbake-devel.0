Return-Path: <avery.brian@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id E561560745
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  5 Dec 2015 18:35:56 +0000 (UTC)
Received: by igbxm8 with SMTP id xm8so58307357igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 05 Dec 2015 10:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=ifjnOCHXLiP0zTW+amkRyialKyU7xHPZr/mRm/K9Ipo=;
	b=n6DFCK1iqYo3Jz/m9l8LJ+rdZjZ06XqB5ux+pNybNVWgnyxS4LpIIe1nJUmuzPIO7G
	aRQDrDPATKx84t60tQUyW+1mzcaE2Je5Ep8RpEeApC49jy1KW976h+aspVej2OxKgYML
	FN0OeyFPDOjXS67zOPuoIU/AekQyGFXOYGkPFCUxIk2oPoFy8UTooh4BG7l5wH6Zy/Zd
	tu52d9CNd3SfbVu0QAgkKajpjb4ymi1AlB8B0YtO5/kEVxC4vD84zfxvY1U/VusC51Bo
	LuXKKxlyfAM7pTIskheh2qTIMLgCXaVMo6NUYdAMXGjiOfSHagb1FN7d/hHdYccs3z0j
	t0+Q==
MIME-Version: 1.0
X-Received: by 10.50.61.230 with SMTP id t6mr9792978igr.28.1449340556985; Sat,
	05 Dec 2015 10:35:56 -0800 (PST)
Received: by 10.64.76.80 with HTTP; Sat, 5 Dec 2015 10:35:56 -0800 (PST)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC7C6F09F4B24@xmail3.se.axis.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
	<43de04cb1abe40187d42e2bc0f20ba9ee200f3b3.1449078919.git.avery.brian@gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC7C6F09F4B24@xmail3.se.axis.com>
Date: Sat, 5 Dec 2015 10:35:56 -0800
Message-ID: <CAKV_0egVMuN_+gw=omsvb4pk+Fy7UUxuy+--yFo9_g_wQx_iHg@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 05/30] toaster: remove unused variable
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
X-List-Received-Date: Sat, 05 Dec 2015 18:35:57 -0000
Content-Type: text/plain; charset=UTF-8

true :/

It was removed from the places in the script where it was used but not
the initialization .

Good catch,
-b

On Thu, Dec 3, 2015 at 5:49 AM, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>> devel-bounces@lists.openembedded.org] On Behalf Of brian avery
>> Sent: den 2 december 2015 19:03
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [PATCH 05/30] toaster: remove unused variable
>>
>> From: Ed Bartosh <ed.bartosh@linux.intel.com>
>>
>> Removed variable RUNNING as it's not used anymore
>> in the toaster script.
>>
>> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
>> Signed-off-by: brian avery <avery.brian@gmail.com>
>> ---
>>  bin/toaster | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/bin/toaster b/bin/toaster
>> index abc8737..1ce4af7 100755
>> --- a/bin/toaster
>> +++ b/bin/toaster
>> @@ -176,9 +176,7 @@ fi
>>
>>  BBBASEDIR=`dirname $TOASTER`/..
>>  OEROOT=`dirname $TOASTER`/../..
>> -
>>  RUNNING=0
>
> The commit message says that it removes the RUNNING variable, but
> the commit only seems to remove some whitespace and not the actual
> variable...
>
>> -
>>  NOTOASTERUI=0
>>  WEBSERVER=1
>>  TOASTER_BRBE=""
>> --
>> 1.9.1
>>
>> --
>
> //Peter
>

