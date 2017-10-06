Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id 0B0A178264
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Oct 2017 20:37:19 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id b189so9681485wmd.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Oct 2017 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=UdMI6+sPq5+zKJvcXBcQZ8L0TpVf3wVztjd1ONB1e3I=;
	b=fFKIXmNb6BSp0n/F784bD2yECVwAleQLV4mPqoPljFqIloksSTN70ETAP1qVKAnITZ
	KbOvx+esvw9lSMz91+IqkKYD9HDfsxXtXM6ldBEuVepHvH9hdF7w9ZVR3Thv9CTAEo65
	NFgNyIdJdfYVuQQ0LDEEuYm5wjP8TZm+GtH4ZwIhVF1FEUq3ABaGQdEol3Glr4+7UUTG
	rK/r3QYfSJ2Njx6daXI3Bx+Ei19WdE7ABbrnABrVd8YB/2oN1mBQ3en7Zm/Vh5nd5Vv0
	FwaYYZnxkTTuXcUKcWdKnJ7SU5QNwJpX6FIx5qek/qkFum3TU065G2+cOtSWWNPGkWSX
	Pxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=UdMI6+sPq5+zKJvcXBcQZ8L0TpVf3wVztjd1ONB1e3I=;
	b=RYFBw9JT8e3Is5R0KD6msgNcf1IsxjTaSFBbAMdyRcgmdqpevQcSjB6av43pz5+NCl
	6bUaJISH64JjrDDbuB7kPMtSyT5qgNeM526WUyUkLQG2n9h/CuOgy4+E7WEXcZehbAL8
	VduN3FHmQfzpNacivGzWferXERcPkbnXy591syeeRYzZLPDEI0kkyXO9NX8GbGq9Po1h
	zmxmRm1oo7S///frLrAV03GGrvPJWfQ6GEXg164kOB6H2VnKCogcD3cyHBbOqc4QUmkI
	ygsIMKOegbTnNNCvY7k3659OpZ/ROToCBSfNMBo5+f8BsPnlUlHkGSooih1IYbmobtG7
	xGfQ==
X-Gm-Message-State: AMCzsaWOhBsB+v99nOsH8ojhRXHhntPXi5Djq9gTRgGCxWvIvSFMWVYV
	5DWrJ447FHe4JGNs6csfeoGi0z404nGIrgRvLjs=
X-Google-Smtp-Source: AOwi7QC3oI4N/EmEynR9Ct8WIpCdKv3Vbld+YmR4bYMTzDtMRG+SBk9ZnpxcGOhWk0pRHb0Jxty5YFdcX+y1SoR68po=
X-Received: by 10.28.54.89 with SMTP id d86mr2643870wma.101.1507322240634;
	Fri, 06 Oct 2017 13:37:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.166.19 with HTTP; Fri, 6 Oct 2017 13:37:20 -0700 (PDT)
In-Reply-To: <CAOtT3B52FFNZHsx+7GQwtLp0qoWvZ3C5AxU4tVYm5cPnAZC3Zg@mail.gmail.com>
References: <1474957465-27791-1-git-send-email-mounesh.sutar@gmail.com>
	<CAOtT3B52FFNZHsx+7GQwtLp0qoWvZ3C5AxU4tVYm5cPnAZC3Zg@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Fri, 6 Oct 2017 13:37:20 -0700
Message-ID: <CAJ86T=XWPVANsJmSW2aPCWKQOEB_r84E-08HTirHSjxQVPxmkQ@mail.gmail.com>
To: Mounesh Sutar <mounesh.sutar@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Mounesh Sutar <mounesh_sutar@mentor.com>
Subject: Re: [PATCH] bitbake warning fix: No bb files matched BBFILE_PATTERN_packageName
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
X-List-Received-Date: Fri, 06 Oct 2017 20:37:20 -0000
Content-Type: text/plain; charset="UTF-8"

> On Tue, Sep 27, 2016 at 11:54 AM, Mounesh Sutar <mounesh.sutar@gmail.com>
>>
>> bitbake is parsing all recipe files, against layers BBFILE_PATTERN for
>> warning message display.
>> In case of sublayer with lower/equal priority, then all sublayer's
>> patterns are not being
>> considered for pattern match. While checking recipe file against matching
>> pattern,
>> the first matching pattern is accepted and added to matched list, while
>> remaning PATTERNs are
>> not being considered. With this, the recipes are being neglected from
>> PATTERN match.
>> This fix let's parser run through all the layers PATTERNs and on matching
>> added to match list.
>>
>> Upstream-Status: Submitted [bitbake-devel@lists.openembedded.org]
>>
>> Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>
>> ---
>>  bitbake/lib/bb/cooker.py |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>> index 4df8881..5fde995 100644
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -1705,7 +1705,7 @@ class CookerCollectFiles(object):
>>                  if matched != None:
>>                      if not regex in matched:
>>                          matched.add(regex)
>> -                return pri
>> +                        return pri
>>          return 0
>>
>>      def get_bbfiles(self):
>> --

Resurrecting an old thread as it's been pointed out to me that this
patch fixes the issue I raised a while ago on the oe-core list:

  http://lists.openembedded.org/pipermail/openembedded-core/2016-July/123466.html

Are there any problems or concerns with this change?

