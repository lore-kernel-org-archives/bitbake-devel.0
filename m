Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
	[209.85.128.46])
	by mail.openembedded.org (Postfix) with ESMTP id 320B87EE4F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 20:52:52 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id b24so3953331wmj.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=hAH7kLcls/jvQLcDMAfDgnOuDNVlldRoPlw31cQhxLw=;
	b=FTH+xK7HvN8ERDm+RAlWA20IaoQXwl3RbhLtI3SqP7CWAs0mQYMP+d59ykCc0aER5H
	Pp7eoGBArqtMhHdhLK9ejFfpiPdeZrhpAlKYQerblsGBXccaiqPRtk2R8c40ZbqrO+i2
	uj90lMh2m3BP2Z6waAF1Wor9RucTi+MYUcGdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=hAH7kLcls/jvQLcDMAfDgnOuDNVlldRoPlw31cQhxLw=;
	b=ooYM0hIvO54OAK4L3Gt3/SlLuwrW7zN1efs4n2KxIogw2Jf8OQER8cZR5aw43zeinx
	kAjLetUAZIndY375k7kuGDJVPC1ibuu3AlSxso3QSkr59PIcj2gm5/O2VXO0txaWiOMn
	BnVWhAu9bxNeoAiFM2WVvUDictiITkYkK4P6vmMjyHLSm7iTLZEgtZclZOx506/bJSyA
	NGU716lB69WmDt74W6X8HAC+USeaZ4LfQQteCnVBy0oSZICkoAaZFNkXlG/LEZJVZ0aE
	lBQEMp5L4u//crCS3f4hYI/LplYOvCFYxOKzV8/ezzKsxnCxzSACpm4pokV9f/att/u1
	gZaw==
X-Gm-Message-State: APjAAAWIwAcuWpZBI2PiLtaMMd6MOBh7UOotuh4JXR6i28Bby/I0YcTL
	0+SMIlcS/3w0yvxxhhbviVIrnw==
X-Google-Smtp-Source: APXvYqyH+3aN6geBpwW8EJopJmV58Z2fy2Zony8FcCgxl83UjSWicb7ICp7uNxf0R2N/h+qXKSVoWA==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr4274901wmz.4.1569531172917;
	Thu, 26 Sep 2019 13:52:52 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o188sm6424737wma.14.2019.09.26.13.52.51
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 26 Sep 2019 13:52:51 -0700 (PDT)
Message-ID: <b1f2e008047cb4c75b7e23fc8b3e92410c8f183f.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Sep 2019 21:52:50 +0100
In-Reply-To: <CY4PR12MB16531DD24CCB0C838C7906608B840@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB16531DD24CCB0C838C7906608B840@CY4PR12MB1653.namprd12.prod.outlook.com>
User-Agent: Evolution 3.34.0-1 
MIME-Version: 1.0
Subject: Re: Keeping multiconfig config files in sync
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
X-List-Received-Date: Thu, 26 Sep 2019 20:52:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Chris,

On Tue, 2019-09-24 at 18:21 +0000, chris.laplante--- via bitbake-devel
wrote:
> Thanks to Richard and others recent hard work, multiconfig is poised
> to become much more practical in YP 3.0.
>  
> One thing I’m not clear on, however, is how it will work in a team
> environment. If I have recipes with multiconfig dependencies, then I
> must ensure that anyone else using those recipes has the exact same
> set of multiconfig config files defined in their
> build/conf/multiconfig/ directory. Or at least, compatible
> multiconfigs with matching names.
>  
> Since these files are under build/conf/, it’s not immediately clear
> how one might version control these. Unless I’m mistaken and there is
> a better way, as a workaround I will probably put the multiconfigs in
> a layer and instruct developers to symlink build/conf/multiconfig to
> there.
>  
> Any insight?

This has bugged me since we first created multiconfig. It was always
intended we'd have configs you could reference. It turned out to be
hard to code and we (well, I) decided to "come back to it". That hasn't
happened yet.

I'd welcome proposals on how it could work (its harder than it first
appears). It'd be good to check we do have a bug open for it too.

So yes, its an issue, I know about it, I don't have a good fix but
would like to see some kind of improvement.

Cheers,

Richard


