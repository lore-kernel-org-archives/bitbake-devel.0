Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
	[209.85.214.51])
	by mail.openembedded.org (Postfix) with ESMTP id DD7D26079E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Jun 2017 13:06:33 +0000 (UTC)
Received: by mail-it0-f51.google.com with SMTP id r63so19217287itc.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Jun 2017 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=6h5367Wbun1lA1QzfItkqTb2OQnLg5ESP06SVhCkrhk=;
	b=1Zkv2BApFA1d/sD2jYpm3zHa5hWQ/L8NdgW4DHDzeUZibYOFr4zJSrK+rpqvYAOrQt
	W5nUOfmG1iCNxzZAlwfsEbGioQfWy+DV2EoTXCu1NU7fS6rkYW74Yx/WR53SPAqEYZgZ
	MAsISSCyiuNGsjFLNZVZGq+qMuijDmF6TrH17+2rwsh3SM19MNEALB3x6FbIXDmTViCF
	/KsR1+o4qxi00O9umJYfqE/Vm2Ed58x5K0gCDJJ1eNIxkP4fyS/cU4InF6TbBCN4a6aK
	EdL5jnxOlUlJsfMko0K4DdGil2DIY4qDFuuPaBkB580Mvhy82OjTfByBFLOUnhIUjqKD
	7cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=6h5367Wbun1lA1QzfItkqTb2OQnLg5ESP06SVhCkrhk=;
	b=jXkIJXLdeTsSHycbD2+alY4xu8LTLW2SvpiRXuVp2ilEzH7y7yRotULvtjlc1H6Lkb
	eho2Gdftr7r2X1KM+nxHJbVuEAvV1bLNEyAg8ZnSzuijnb2cZTySezI7eZxF+Elxj56s
	JI1A6lqZYdFChUXoBoMQdX330HZIvwIGbdDWxX6JpRd343ef6RUTUkKnECyaOVDnmWZX
	s9xAjC+ojrScA8toi8vyzDzF193/AxM2LdK/7ZM1xbLrrhH3007oKyveKOrbBYJS3qn6
	5qFyGH4SSVUIAtM26NfpTWtSjIRjSitZzJncUUpEOgDD4x46ehr0e6ZFrW6aJ03MNEcr
	n6ow==
X-Gm-Message-State: AODbwcC5CIjBf+e3K5GjdnRfIAysKYRnEKMrjmYhsNzwA42xwlmgpcvx
	UWhVPVEtOEpaalmp
X-Received: by 10.36.75.12 with SMTP id q12mr4419462ita.34.1496408794628;
	Fri, 02 Jun 2017 06:06:34 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8E6B0.dip0.t-ipconnect.de. [93.232.230.176])
	by smtp.gmail.com with ESMTPSA id
	g12sm10184675iog.60.2017.06.02.06.06.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 02 Jun 2017 06:06:33 -0700 (PDT)
Message-ID: <1496408790.30163.24.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 02 Jun 2017 15:06:30 +0200
In-Reply-To: <1496408295.6630.95.camel@linuxfoundation.org>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
	<1496408295.6630.95.camel@linuxfoundation.org>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
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
X-List-Received-Date: Fri, 02 Jun 2017 13:06:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-06-02 at 13:58 +0100, Richard Purdie wrote:
> I'm wondering if there is a hybrid solution if we extend this syntax a
> little, e.g.:
> 
> BBFILES_DYNAMIC += "\
>     XXXX:${LAYERDIR}/optional-bbappends-XXX/recipes-*/*/*.bbappend
>     YYYY:${LAYERDIR}/optional-bbappends-YYY/recipes-*/*/*.bbappend
> "
> 
> so that the code only applies these BBFILES entries if the layer named
> in the first parameter is present?
> 
> This would happen at the end of parsing so ordering becomes a moot
> point. The direction you stack BBFILES_DYANMIC in would determin
> bbappend application order.
> 
> How does that sound to people?

Sounds good to me.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




