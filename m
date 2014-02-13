Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
	by mail.openembedded.org (Postfix) with ESMTP id 7BA7F6EB24
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Feb 2014 13:18:06 +0000 (UTC)
Received: by mail-ee0-f41.google.com with SMTP id e51so4440891eek.14
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Feb 2014 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:date:message-id:in-reply-to:references:user-agent:subject
	:mime-version:content-type:content-transfer-encoding;
	bh=SngFrX10nSu73vnYbe+cJZboZbdRSfePH9tuBVQGKUI=;
	b=w/teMLstlT88GZfsiWMWbNoqWacGmKukXGc9Geskjr71qfZIz7FvQ0q9XtjY7UWAGu
	Dd7hbpNS/ZmmI+kNOc0qJB+wCVsIDq/gLzbcSnoISJSzD1YUNLoeTe2qVE8I6MxpD8Py
	/5gLitrBbAokE+7Wlr82uEw2uN7+56BhC/+l/rQfLPBFtauq40St0CLuvfUP/UVnq9zK
	83iQTHFX7IqoEMeyN4eR6Gd92/4ZLy8tg2YgKEhPFUbOvYR2ArCSmD9MfASpTkSmdjV1
	Ea0VcrgthSY7MHslLYhZMBrdZf4v+BMYOhgFt9buxZd5LO/uSnOzD2LpmYQKH96NzweX
	6eAA==
X-Received: by 10.14.205.3 with SMTP id i3mr1782560eeo.23.1392297487105;
	Thu, 13 Feb 2014 05:18:07 -0800 (PST)
Received: from [46.206.16.206] (046206016206.atmpu0017.highway.a1.net.
	[46.206.16.206])
	by mx.google.com with ESMTPSA id o45sm6877385eeb.18.2014.02.13.05.18.00
	for <multiple recipients>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 13 Feb 2014 05:18:05 -0800 (PST)
From: "Bernhard Reutner-Fischer" <rep.dot.nop@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel" <bitbake-devel@lists.openembedded.org>
Date: Thu, 13 Feb 2014 14:18:00 +0100
Message-ID: <1442b656830.2760.0f39ed3bcad52ef2c88c90062b7714dc@gmail.com>
In-Reply-To: <1392072628.7120.64.camel@ted>
References: <1392072628.7120.64.camel@ted>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:9.0) Gecko/20111222 Thunderbird/9.0.1 AquaMail/1.3.8 (build:
	2100414)
MIME-Version: 1.0
Subject: Re: [PATCH] runqueue: Fix setscene hard dependency problems
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
X-List-Received-Date: Thu, 13 Feb 2014 13:18:06 -0000
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 8bit

On 10 February 2014 23:51:18 Richard Purdie 
<richard.purdie@linuxfoundation.org> wrote:


> +
> +                    if not self.rqdata.runq_setscene.index(taskid) in 
> self.sq_harddeps:
> +                        
> self.sq_harddeps[self.rqdata.runq_setscene.index(taskid)] = set()
> +                    
> self.sq_harddeps[self.rqdata.runq_setscene.index(taskid)].add(self.rqdata.runq_setscene.index(task))

pythonic nit: setdefault ?
Thanks && cheers,

Sent with AquaMail for Android
http://www.aqua-mail.com



