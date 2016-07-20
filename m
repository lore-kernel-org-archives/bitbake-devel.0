Return-Path: <patrick.ohly@intel.com>
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com
	[209.85.161.170])
	by mail.openembedded.org (Postfix) with ESMTP id 368BE606A8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 15:34:26 +0000 (UTC)
Received: by mail-yw0-f170.google.com with SMTP id z8so26758019ywa.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=0YBRikaIN+fUtKIf6nKLuM8v/pdD54uoM5bmk3J/WnA=;
	b=sKJL6sFRRoN1n1+LEmwgAc2Dn3h5lqf2GjjsPZNhZbi5deVRS1mcQNi88Tj46bCkV7
	6DknXlvz46k1iTvP7viZM/+qOH6+YW6+qOvNBqI/g8xjYSjBG/yYSsdK3qls0WfnDP+Z
	lJia/e5NuLLTpx19JdNQDllgJLB/M7xGjnTjNQ5GrvcKBKg4E+BgB0ldRU8Q2Z/jVlOx
	zWZQuC/cx1aD/JLL2/FcsGpkbndJyw5OCPyC2fFbKJbgHTSNv244eStew5h/SrBpHXlV
	9o35lsfq78Nl8+1wile0jgADy/EqppyzaLCvNQqsmDqjFfptcMzKQHSrJ4QLBygBj0yt
	+rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=0YBRikaIN+fUtKIf6nKLuM8v/pdD54uoM5bmk3J/WnA=;
	b=F8gNulEr4tOeR/+pU3jSiDDrlw+xBhOQR7zbD1eKztWvgqvd96aYdhaY2rHrMCUyaX
	tzzYTN7kJUhr/0nCX0uDeAVB41b/uqyivIZ23weZOPuzbl2hS2RLEbqklK34yLwHckq1
	QP2/cfWertAx0kV1sn5ZSvdPRJU8mdd3svdh4+YXhITLE0oGo9rZAbm2waefrKp3vH2B
	If3WikugD6sxCEx5kDjNi9uZmRh9xJny53LOllv6BwZhA0HRYCGU5suRNoxAh2FW66dJ
	qsvh0wH8ThZevJKsa5i4lHGff1FsUOTyJ0gfjKHCy8hgzpnbEAAc7pBR5cbt2qfbIm0r
	bsIw==
X-Gm-Message-State: ALyK8tIeG11J/4vq0bfL/xB9clb7fDKr3X9ksTMW/Ko8oFcuBG2Bds/hOb0u4MXuKH+HQw0m
X-Received: by 10.13.217.20 with SMTP id b20mr31687148ywe.44.1469028867333;
	Wed, 20 Jul 2016 08:34:27 -0700 (PDT)
Received: from pohly-mobl1 (p57A57E84.dip0.t-ipconnect.de. [87.165.126.132])
	by smtp.gmail.com with ESMTPSA id
	f62sm1212910ywh.19.2016.07.20.08.34.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 20 Jul 2016 08:34:26 -0700 (PDT)
Message-ID: <1469028864.20940.0.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Wed, 20 Jul 2016 17:34:24 +0200
In-Reply-To: <1469027297.23580.17.camel@linuxfoundation.org>
References: <1469027297.23580.17.camel@linuxfoundation.org>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Fix incorrect dot file generation
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
X-List-Received-Date: Wed, 20 Jul 2016 15:34:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-07-20 at 16:08 +0100, Richard Purdie wrote:
> In the runqueue cleanup/conversion, "dep" was mistakenly used where "tid" should
> be leading to incorrect task-depends.dot files and causing general confusion. 
> Fix this, its clearly incorrect looking at the code.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 9bd3460..a73a55d 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -744,7 +744,7 @@ class BBCooker:
>              for dep in rq.rqdata.runtaskentries[tid].depends:
>                  depfn = bb.runqueue.fn_from_tid(dep)
>                  deppn = self.recipecache.pkg_fn[depfn]
> -                dotname = "%s.%s" % (pn, bb.runqueue.taskname_from_tid(dep))
> +                dotname = "%s.%s" % (pn, bb.runqueue.taskname_from_tid(tid))
>                  if not dotname in depend_tree["tdepends"]:
>                      depend_tree["tdepends"][dotname] = []
>                  depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, bb.runqueue.taskname_from_tid(dep)))

+1, this is indeed fixing the issue I was seeing. Thanks!

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




