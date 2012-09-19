Received: from mga07.intel.com ([143.182.124.22] helo=azsmga101.ch.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <scott.a.garman@intel.com>) id 1TEDT5-0006dF-Tb
	for bitbake-devel@lists.openembedded.org;
	Wed, 19 Sep 2012 08:09:04 +0200
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by mga03.intel.com with ESMTP/TLS/RC4-SHA; 18 Sep 2012 22:55:14 -0700
Received: by pbcwy7 with SMTP id wy7so1587111pbc.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Sep 2012 22:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=qNKxJ+IX5dwV3t3tX+cl4mAfMJBsLltuvFlPvIDGsLc=;
	b=lTRvTUyq3JY2RwsI5cNsbiIcArbagGDj/bnXBwMPIFY7oRgdjTto23OrW7/9D/gyWL
	Jkb0fclfuaVLWxVmS60c+C+yqEYfZP2pZib9XlF96qt0DHgFQS7xBGsKa45bnVMdRO4j
	iHjuirQwkyISbgjoH7wT1wDrZSuQwXQyAs7fFxN8UEdOoGa+0nay48xTXFsrj2YVhFGW
	2J/reu5xjWYohSTeMrPJ56IugkG6OhGsmd7QfQkeBENKkxiaBDr+eI/3f9HLkT5m1jLQ
	oVIji2rbAKurN28LMVxM0KhkxD30YWRvu5CcVn2X2DuA5+852f8uL1XW0lYNGKz4ZjjL
	54EA==
Received: by 10.68.233.97 with SMTP id tv1mr4584835pbc.96.1348034113363;
	Tue, 18 Sep 2012 22:55:13 -0700 (PDT)
Received: from [192.168.1.104] (c-76-105-137-48.hsd1.or.comcast.net.
	[76.105.137.48])
	by mx.google.com with ESMTPS id f9sm507955paz.1.2012.09.18.22.55.12
	(version=SSLv3 cipher=OTHER); Tue, 18 Sep 2012 22:55:12 -0700 (PDT)
Message-ID: <50595E3F.5070201@intel.com>
Date: Tue, 18 Sep 2012 22:55:11 -0700
From: Scott Garman <scott.a.garman@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1347273777-26676-1-git-send-email-bogdan.a.marinescu@intel.com>
In-Reply-To: <1347273777-26676-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Gm-Message-State: ALoCoQl3VzJ7mjDAV1fyuv2xmZeCZc4TCcqguYfzc0FvVphOAQVrLAVxXp47QWg/IkxQxBc12akY
Subject: Re: [PATCH] [for-denzil] Save proxy settings
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
X-List-Received-Date: Wed, 19 Sep 2012 06:09:04 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2012 03:42 AM, Bogdan Marinescu wrote:
> Proxy settings were not properly saved between Hob runs. This
> fix is mostly a backport of code in master.
>
> [YOCTO #3024]
>
> Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>

I have this in my sgarman/denzil-next branch now, thanks!

Scott

-- 
Scott Garman
Embedded Linux Engineer - Yocto Project
Intel Open Source Technology Center


