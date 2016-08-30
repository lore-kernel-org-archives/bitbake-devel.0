Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id 9A2546FF7B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 20:41:00 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id w207so533038wmw.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=2KsYJlw+adzNNy4fSBHtrJNt8S33U4aeSqQ29ACv+xs=;
	b=Xxrun/OWmOc6FzWdi+14SuWMOBMCWjch+8YJp03J1WtLBdOzgmsq3tsTi/w/WnSyji
	hidoIhTYAejjO3xobU8cRY99sV76Zks/A1JUroHbxGkXqJY4c2PTigd5yLMZ+8IMXtVt
	PVkbOjSLEKKcjrGLB/dq+8gTNPg4vdrdcucc70UgCE0FNysTel5q/mV1YSSvl7vQse3R
	gnfjGJ9FBtGMSXyi76jNS/pK28IHrNPwle3My2WMQjw8w4HS7GdUWCvs5A/PMsZ5k6cy
	Q7WEKAR+BaXnWm29UqPuG9jySFNVLH5jYra/ffWmwpFXsuGuBTiYlJ2ObGh7DsyHF0SP
	T9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=2KsYJlw+adzNNy4fSBHtrJNt8S33U4aeSqQ29ACv+xs=;
	b=RRGA32P6z74BI3QtZ4oktgZpYF5bZJh4wTFmmHUcDua+duDRqUr8RQzEIgmxgrlB0H
	P3NIpsyNU30qIZX3wBB+RKs8hWQgYEO5O1/iOUkhXWm6Lh7ggFWGuXzKnb87gkE+UHgo
	uYlwQpvhzNO2v9OrcN0mYTwNKqSEIsQdGDX6hmKZcr9nL5xExp5TR5IgHH/Om6QCQdxb
	3PkiIow3aiKKygnjAr+PUlzcZTtWFMn+fRCxqJJ9KKnjxcl7SsWoTnEpvMWXnXUBx+BY
	Ylh+dQCK6kIuEp0MbkJ8RL+lbM8kyryNvFMqYSFqRuTR4j0hWhY/rjtEqoUBlm20sTdF
	2CSg==
X-Gm-Message-State: AE9vXwOW+M1RUiarC2xus+1xlcYE2yudOazPK53eYqqheXHGoL5hK5gb1g8O94xbpTv5gDb4eSus0m877ZtzTw==
X-Received: by 10.28.181.66 with SMTP id e63mr17088796wmf.116.1472589660625;
	Tue, 30 Aug 2016 13:41:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.195.10.194 with HTTP; Tue, 30 Aug 2016 13:40:59 -0700 (PDT)
In-Reply-To: <CABcZANm8Uxn=WVzgsyPimB3a-pM3_c+piVtzZVFMJLFW+THwbQ@mail.gmail.com>
References: <CAJ86T=UnA3cUU80pdTfgAvc0Ht-Pc9sJJoUK5rjdvuoUKa+4sw@mail.gmail.com>
	<CABcZANm8Uxn=WVzgsyPimB3a-pM3_c+piVtzZVFMJLFW+THwbQ@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Tue, 30 Aug 2016 13:40:59 -0700
Message-ID: <CAJ86T=WDWXPisRh-s_09_x8UqJcHcKKpgFNJBTTEjvSy9z4y_A@mail.gmail.com>
To: Christopher Larson <clarson@kergoth.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: How to prevent expansion of bitbake variables inside tasks?
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
X-List-Received-Date: Tue, 30 Aug 2016 20:41:01 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 30, 2016 at 7:59 AM, Christopher Larson <clarson@kergoth.com> wrote:
>
> On Mon, Aug 29, 2016 at 7:12 PM, Andre McCurdy <armccurdy@gmail.com> wrote:
>>
>> Say I want to create a do_install() task which does:
>>
>>   do_install() {
>>     echo '${BP} was ${BP}' > ${D}/test
>>   }
>>
>> but I don't want first ${BP} bitbake variable to be expanded. ie after
>> the task has run I want ${D}/test to contain the string "${BP} was
>> foo-1.0".
>>
>> What's the recommended way to escape the first ${BP} in do_install()?
>
> Sadly this was an oversight when the file format was originally created, so
> there's no real way to escape the variable reference to make bitbake not
> expand it. There are workarounds, of course. You could do some or all of the
> work in python rather than shell, since python functions don't get their
> variable references of that sort expanded, for example, or you could
> construct the output / break up the reference, i.e. echo '$' >, echo '{BP}'
>>, or easier, use printf to do it with format strings, i.e. printf '${%s}
> was ${%s}\n' BP BP >${D}/test.

My solution up to now has been:

  echo '{BP}' | sed 's|^|$|'

but printf looks a little cleaner. Thanks.

> --
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics

