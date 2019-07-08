Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by mail.openembedded.org (Postfix) with ESMTP id 8EA8D7D080
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Jul 2019 09:48:22 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id h10so15221555ljg.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Jul 2019 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=4lyLGkhA7cdL2ZERkTyKoFMl1xxUohOUQO/LY2dbfqg=;
	b=I5tHqH04bSvCgI2lt9N4euXWh8b42n8HYllOI5eA2JVsuufhXPrjVDlGfGjg4qCVU9
	rLJsIinUeTU+1eQYCJfk7PFPoDmGhbDUA6SHLfO4h3/JOdj6dlsLRmmH9MBj5JNemS6u
	AzhnP6LEdQ2xop3N9q1jPT9/4IURC3ngNiD4C6NntdmQXwJDUZslo7fxViteLCt/gVKn
	UpSz8z8HMfL6K+Pk79JSfRbFDiySN4odS5EALMO+pf32dizPL4iX3XRR1/OIoG6mErdJ
	h+kH1BGI9dekqU9qsjZjiRHyk55X+e6Z3JhSoroDfsnKGjtyfTRhrUxhGzbm5t80Q+2i
	H3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=4lyLGkhA7cdL2ZERkTyKoFMl1xxUohOUQO/LY2dbfqg=;
	b=q9zuij968yda5wwHnKOIhkxwyvFCVQdV9snC8IOk3wZI6m2vGIBl5l/vgzAqDM1Q18
	ik04vEc0PQDbgT4hDuBe2pxaQRfBgccuIMokPUo78cWMxAbeyaa3B/rY51G9IEXznXWN
	CsRaja5jFsO9La+tdNsNbwGUWlyv35ixFFSgKMZnAH51LAqrHvbEVWvVj/mb576u7Svk
	H7Wf1TFpQRAZctOqPYXgs+ozRhC3w7qpbCuDqCPQAMkYT5ZTn2M4PffG7l/t0m2F89YV
	yqDDkDO0d9E7J54qqm/SkO7TcrjRKyXDnnwccRLpmYwqfzdnuYItfRepbS98+r2XN/Yp
	8uKw==
X-Gm-Message-State: APjAAAVxwZjSMP49xS9ob2wXvXSH8X5EN4XIsVnj16+U4Pen8sOv4H6j
	b3oiIhZaCz+c+zqFvOINWxQxN1vO/+DrAX0GdAs=
X-Google-Smtp-Source: APXvYqyjGS6OauEZQfZAN9ZHwmv76dDGUrSys3bon7N9PwoWUzpaTCPJxlyiEtMShEBmsQMS6bi8g4i+cnLNW19M4qI=
X-Received: by 2002:a2e:a171:: with SMTP id u17mr9951626ljl.209.1562579302843; 
	Mon, 08 Jul 2019 02:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<CADySD0E1_H-42rdzxxKSEdHYAmCLenxL+C7KWS0xkhJYqC4aBQ@mail.gmail.com>
	<8d94fa48-50b6-c3a6-38a4-9a680e5a6d3a@gmail.com>
In-Reply-To: <8d94fa48-50b6-c3a6-38a4-9a680e5a6d3a@gmail.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Mon, 8 Jul 2019 21:48:12 +1200
Message-ID: <CADySD0Et1owyNBJGius+5k87iNmQ-9OKiqYeQXM1tBnDiL-Apw@mail.gmail.com>
To: akuster808 <akuster808@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
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
X-List-Received-Date: Mon, 08 Jul 2019 09:48:22 -0000
Content-Type: text/plain; charset="UTF-8"

Thanks Armin, I will wait for some more time then

On Mon, Jul 8, 2019 at 3:06 PM akuster808 <akuster808@gmail.com> wrote:
>
>
>
> On 7/7/19 12:55 PM, Ankur Tyagi wrote:
>
> Ping
>
> Regards
> Ankur
>
>
> This needs to land in master first before it can be backported.
>
> I don't see this in the patchwork either., not sure why
>
> - armin
>
> On Thu, 4 Jul 2019, 4:45 p.m. Ankur Tyagi, <ankur.tyagi85@gmail.com> wrote:
>>
>> Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
>> ---
>>  lib/bb/fetch2/git.py | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>> index 59a2ee8f..a8fcc2bf 100644
>> --- a/lib/bb/fetch2/git.py
>> +++ b/lib/bb/fetch2/git.py
>> @@ -156,6 +156,9 @@ class Git(FetchMethod):
>>          if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
>>              raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
>>
>> +        if ud.proto in ('http', 'https'):
>> +            ud.path = ud.path.replace(" ", "%20")
>> +
>>          ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
>>
>>          ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
>> --
>> 2.17.1
>>
>
>

