Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 21879719EF
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Nov 2016 12:30:29 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id n67so46776033wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Nov 2016 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=subject:references:to:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding;
	bh=MtGXs5GGC74LDgNuk+wPEc8RxDXTsdyKzgdT/QYv/wM=;
	b=WWgZ9HzbI+pgVIrLdG0rhleTfRQwVydLXTGRGV+yr7/vtYpV81QA8lIF3M+pAQG0Tr
	LpfNwhf+MQzaG9/cgpy7Ndp8pGRKAJAJ+IMMtMhi+MCgwIULT3su1saxbOk6bZw0FIFF
	CGTJzYkMNb2GrDIdpY1ReOtfert1l3ICkisaZf2MuhE2omBaxnrIbznxn2kQLa/Z+RJF
	s1Sgc5TgK+jG9rPevwkjiDw3EKQJuM4Vdto5cJl/IoDDMD0LGoMuevY/FIKuFwPiZnMt
	yRaRaWF62Mr/G0I+RVwEXPeE6lFgWYzuLlfB3MN9NZYm389Xhzxc2nV5djPrF7nnUFXV
	Q72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:references:to:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=MtGXs5GGC74LDgNuk+wPEc8RxDXTsdyKzgdT/QYv/wM=;
	b=EAqDTUhu+e7yqUQ3S2aQ/c0bF8810MrvsuU3PSMDDGN18p865uy+xgHxBb64CY4IMv
	m2zDDLTtLsaPqNXcczeHd2XWlqCKTPMqHj1WN9P6fyWAkoAYXDuatyPZMpkr2c0Wpk2o
	5UHn5etBeiNBorCaL4SGHxjJ/CweDmWf9+0fruhDMpXBMCNksxkodbpG60hFYclykz5A
	zc/3oqSj1xD8GL+cNPxQgW5qWEpVmtGaAlnw7mNqm/QHtYGDp+2JfddtBm/lS/2yocG4
	Ln7eAyS6agSRSJV0QO+SqKv1SXB4jrcnUHKhguwj52nKTSdR+3lCoz/KjgE4VCGV7AIx
	5a+g==
X-Gm-Message-State: ABUngvcrY668cJGkUEHpVbpvqYhMDv9uCFyTsbrNZRxTAJyU6FFSNgmtcSY/XD5OQQxyglp/
X-Received: by 10.195.11.134 with SMTP id ei6mr11613849wjd.176.1478262630458; 
	Fri, 04 Nov 2016 05:30:30 -0700 (PDT)
Received: from [192.168.0.78] (host31-48-249-102.range31-48.btcentralplus.com.
	[31.48.249.102]) by smtp.googlemail.com with ESMTPSA id
	u64sm4370961wmd.6.2016.11.04.05.30.28
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Nov 2016 05:30:30 -0700 (PDT)
References: <1478262426-5350-1-git-send-email-michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <7a43f58b-8ced-2032-1d1e-3dcebc4a4301@intel.com>
Date: Fri, 4 Nov 2016 12:30:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1478262426-5350-1-git-send-email-michael.g.wood@intel.com>
Subject: Re: [PATCH][master/morty/1.32] toaster: settings set ALLOWED_HOSTS to * in debug mode
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
X-List-Received-Date: Fri, 04 Nov 2016 12:30:31 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/16 12:27, Michael Wood wrote:
> From: brian avery <brian.avery@intel.com>
>
> As of Django 1.8.16, Django is rejecting any HTTP_HOST header that is
> not on the ALLOWED_HOST list.  We often need to reference the
> toaster server via a fqdn, if we start it via webport=0.0.0.0:8000 for
> instance, and are hitting the server from a laptop. This change does
> reduce  the protection from a DNS rebinding attack, however, if you are
> running the toaster server outside a protected network, you should be
> using the production instance.
>
> [YOCTO #10578]
>
> Signed-off-by: brian avery <brian.avery@intel.com>
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> ---
>   lib/toaster/toastermain/settings.py | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
> index 3dfa2b2..aec9dbb 100644
> --- a/lib/toaster/toastermain/settings.py
> +++ b/lib/toaster/toastermain/settings.py
> @@ -60,9 +60,19 @@ DATABASES = {
>   if 'sqlite' in DATABASES['default']['ENGINE']:
>       DATABASES['default']['OPTIONS'] = { 'timeout': 20 }
>   
> -# Hosts/domain names that are valid for this site; required if DEBUG is False
> -# See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
> -ALLOWED_HOSTS = []
> +# Update as of django 1.8.16 release, the '*' is needed to allow us to connect while running
> +# on hosts without explicitly setting the fqdn for the toaster server.
> +# See https://docs.djangoproject.com/en/dev/ref/settings/ for info on ALLOWED_HOSTS
> +# Previously this setting was not enforced if DEBUG was set but it is now.
> +# The previous behavior was such that ALLOWED_HOSTS defaulted to ['localhost','127.0.0.1','::1']
> +# and if you bound to 0.0.0.0:<port #> then accessing toaster as localhost or fqdn would both work.
> +# To have that same behavior, with a fqdn explicitly enabled you would set
> +# ALLOWED_HOSTS= ['localhost','127.0.0.1','::1','myserver.mycompany.com'] for
> +# Django >= 1.8.16. By default, we are not enforcing this restriction in
> +# DEBUG mode.
> +if DEBUG is True:
> +    # this will allow connection via localhost,hostname, or fqdn
> +    ALLOWED_HOSTS = ['*']
>   
>   # Local time zone for this installation. Choices can be found here:
>   # http://en.wikipedia.org/wiki/List_of_tz_zones_by_name

Should also say that this is needed for backport because the 
requirements for django was effectively also added as a backported to 
the version we are currently using i.e Django>1.8,<1.9

More info in Brian's cover letter on the toaster mailing list.

https://lists.yoctoproject.org/pipermail/toaster/2016-November/005300.html

Michael


