Return-Path: <avery.brian@gmail.com>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
	[209.85.223.179])
	by mail.openembedded.org (Postfix) with ESMTP id ED10373E11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 14:14:25 +0000 (UTC)
Received: by iodv127 with SMTP id v127so10160994iod.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=3g8SfXr5MSHcwQEysRgSRuUIozZgDarJeRtr8JRVGt4=;
	b=GV27MZrVz5bA9HMBxYsyFV8zB4pKlopAPw8aOmJU+AnGzjw7y4qqYfZPJ16Gei8W7k
	T1ImDnoWoD6iRoNTVOn/3+P8uBnI81sXlvjEgwQN3Qp409UZuS2hILZwzwk6iDF0HbCC
	dTaqRtRzT5QHq7pch+7kdaQmgj6jVwpWRpkzAlwaLk1xrygU0TwmQPQggSKxEpafdugu
	1cInHs1/CeCR/2MxTsMp0YYn4xrnoQ8hZdKyzdvgsWFAabJML0/lqInolUxnFIOK3iWm
	zKkvU5aW3snanZ6gkuXA0GTBVGFzySgfGfHhqJAAkegVqiPVMyEut4q3iR2EDp0kMtSG
	A5/Q==
MIME-Version: 1.0
X-Received: by 10.107.136.221 with SMTP id s90mr14124167ioi.34.1439993665869; 
	Wed, 19 Aug 2015 07:14:25 -0700 (PDT)
Received: by 10.64.55.39 with HTTP; Wed, 19 Aug 2015 07:14:25 -0700 (PDT)
In-Reply-To: <CABcZANn4Jzrb727wz1A=90EiMhk+KEweASe+Vjg+2Ge5i=zP7Q@mail.gmail.com>
References: <cover.1439935538.git.avery.brian@gmail.com>
	<f87bc73e473e8b69734b18d5fb7512af90ed7a49.1439935538.git.avery.brian@gmail.com>
	<CABcZANn4Jzrb727wz1A=90EiMhk+KEweASe+Vjg+2Ge5i=zP7Q@mail.gmail.com>
Date: Wed, 19 Aug 2015 07:14:25 -0700
Message-ID: <CAKV_0egc8fJ5C1VgYC_bD+1kC6_mzwozn5LXgei4UXFoMTGNNw@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Christopher Larson <clarson@kergoth.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake: toastergui: Call csrf function in all pages to ensure cookie is sent
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
X-List-Received-Date: Wed, 19 Aug 2015 14:14:28 -0000
Content-Type: text/plain; charset=UTF-8

Noted for the future, sorry. Figured my 1st time would be entertaining :).

Should I resubmit?

-bavery

On Tue, Aug 18, 2015 at 6:41 PM, Christopher Larson <clarson@kergoth.com> wrote:
> On Tue, Aug 18, 2015 at 3:11 PM, brian avery <avery.brian@gmail.com> wrote:
>>
>> From: Michael Wood <michael.g.wood@intel.com>
>>
>> Not all pages call the csrf token template function so django does not
>> bother to send the cookike, this meant that all subsequent ajax calls
>> fail. So add this to the base template.
>>
>> [YOCTO #8175]
>>
>> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
>> Signed-off-by: brian avery <avery.brian@gmail.com>
>
>
> Patches sent to bitbake-devel shouldn't have the 'bitbake:' commit subject
> prefix, that's only appropriate in poky.
> --
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics

