Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>)
	id 1QoG1T-0003Oe-Cq; Tue, 02 Aug 2011 16:32:43 +0200
Received: by vws2 with SMTP id 2so5667882vws.6
	for <multiple recipients>; Tue, 02 Aug 2011 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=8127Imnzw27FroYapIzfKBvkl9Uj84WX++0Z0yHnN6M=;
	b=TfVlX+FVLhzjLuomlRJRkgcKQjKq7ZJVMW0cAz+Ra3HgjnJqCS6SkQbvO/NStDaq3C
	nJ0nuujqGNJBhqH4uJfrcSRke5T7R0W3o2PmGxQRJ4eEam+O9rReV6EPDBwaPHdbqYlK
	6pHs0tPLXcLohjIHYusEIhwBdlIil3WUrVtgo=
Received: by 10.52.92.2 with SMTP id ci2mr5385673vdb.428.1312295298196; Tue,
	02 Aug 2011 07:28:18 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Tue, 2 Aug 2011 07:27:58 -0700 (PDT)
In-Reply-To: <201108021521.38404.paul.eggleton@linux.intel.com>
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<1312293167.4325.38.camel@phil-desktop>
	<CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
	<201108021521.38404.paul.eggleton@linux.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 2 Aug 2011 07:27:58 -0700
X-Google-Sender-Auth: kDXXclJ_wrxq4rkHFQJz0qAmrNE
Message-ID: <CABcZANmfd=HbE-wLQ6y-6s_DNYOhDQ7uYPuJ=Yebb6cpVpnykA@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Layer priorities influencing default version selection
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 02 Aug 2011 14:32:43 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 2, 2011 at 7:21 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> On Tuesday 02 August 2011 15:14:41 Chris Larson wrote:
>> as config/class priority is
>> determined by order of entries in BBLAYERS, whereas recipe priority is
>> determined by layer.conf.
>
> Is that a good thing though? At the moment I'm not convinced that it is.

I probably could have worded my reply better. I was pointing out the
fact that the order is determined in two places right now as being one
reason why I agreed with his statement that ordering determined by the
layer isn't ideal.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


