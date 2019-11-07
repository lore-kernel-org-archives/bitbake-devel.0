Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 483417F8DB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2019 19:45:23 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id p4so4433434wrm.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Nov 2019 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=4vNq7ai9fRuycQnAeCNTdT1n6XG/05daoulLkQ4N2G8=;
	b=NbccjPEW4QyGSVjlqlF40w9HL0n66+rwmw7hiVSISOJioKUL8sVNykdzcWIOMyOwRd
	1Yy5aXbcOBjs9pGjxCKMgCB0dJQP+4UTTLO8nJFJnysqzF1w94mq3xG6PnGqG+1vGjA/
	K4xbbhu44PMDyKiwmvFKWHL+XG9V6t1BB3TB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=4vNq7ai9fRuycQnAeCNTdT1n6XG/05daoulLkQ4N2G8=;
	b=hiK8Dcv1C3zQu4m3shQvRXV/jAjdLn/5DEYD4M0QP8pKUDfT84SnH5aQSHaNKxVUeN
	+BVw+9He28fVyGjGao1BzyDxBTMDkwXy+n/w50UpTlLlDkxIaY3+LqJDJyGc2zyvVwsK
	0XmAlQyltban5PtYOq6S+7ej4ZIdGjXvoDNoz8vRgpjSUWKi07xXy2UM0UJdi+n6k8qm
	PyeqIXGILm4b5RYeA1W9UC/WlFB8HwRIZ9P0XAhNiczSg57aPJ1vtLKPPxLtwkt8cMl2
	dwcTredOzClnWNh3fw+/y6vBREN8QpuoYWUjVU0gd88fnb6PpzTc36TXlCrh7sdvRw53
	8kzQ==
X-Gm-Message-State: APjAAAU5F/BBKGbFj53CIwXsLIO2HCPumpZOA5c5qBYaGzLAhYjTXnKn
	tAE3If7TvxuR3TwzKs7iFVIdP9nGZn0=
X-Google-Smtp-Source: APXvYqzlpjxTCH+Z8tWm0sKEoWoqck3ByNQJvZIFU0ASs+3rzXkPIZMdq8BOHeYHBE0nW9sRV/nAtw==
X-Received: by 2002:adf:e387:: with SMTP id e7mr4604631wrm.180.1573155923931; 
	Thu, 07 Nov 2019 11:45:23 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o187sm3158537wmo.20.2019.11.07.11.45.22
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 07 Nov 2019 11:45:23 -0800 (PST)
Message-ID: <a1a450081b95cd56557a5c0341ab46ed601b059e.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 07 Nov 2019 19:45:21 +0000
In-Reply-To: <CY4PR12MB16530118DE572B2CC64389008B780@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
	<CY4PR12MB16530118DE572B2CC64389008B780@CY4PR12MB1653.namprd12.prod.outlook.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/9] BitBake Vim indentation plugin
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
X-List-Received-Date: Thu, 07 Nov 2019 19:45:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-11-07 at 14:41 +0000, chris.laplante--- via bitbake-devel
wrote:
> > This patchset adds Vim indentation support for the BitBake
> > language.
> > 
> > It supports indenting variable assignments, Python and shell
> > tasks/functions.
> > To accomplish Python indentation, it uses a hacked-up version of
> > the Python indenter
> > from Vim upstream. The upstream shell indenter is used directly,
> > without
> > modification, however in the future it will be necessary to modify
> > the shell
> > indenter to properly support "fakeroot" shell tasks.
> 
> Heads up, it seems only the first two commits in this patch series
> were committed to Poky. Could someone please commit the remaining 7?

Fixed, the rename in patch 3 broke the tooling but I sorted it out
manually.

Cheers,

Richard


