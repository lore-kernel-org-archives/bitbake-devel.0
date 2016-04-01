Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id 722C973172
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 14:42:58 +0000 (UTC)
Received: by mail-pa0-f50.google.com with SMTP id fe3so92025472pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 01 Apr 2016 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding;
	bh=7ERydUb5GHs4SAo2aYRuYC3oG/4RIdFn+3ZEZt/VQL8=;
	b=VUoIRTRlq6dpDCTFsDrsqSyxfIYCjI3Li6jmk6zanpqcYxxrFHTEzDStRqhWz0tMy+
	dfDlCTt6g1pFeHt9bKFqmBzXgDaDoWQguZ9nMV+Za9uxglJllUfO2LkJJwCwz9T4U6o7
	RCI2+/3UK7APOIM680Uj2KFZKlnV4/ZZq3fLy0FiE25FSKpQygTHCXLAMrMGjXMOa3Ew
	dqdBamaBmHAj6l5uylYsay0g1ZysN9wD6uGVPBF4EHhZrkRGTZM/sbzjBtHk28ZhaGrw
	qsetQaAl02aG3TzarZ03Zd+YW+oPpohGs+StVZ2uhe9+P01oBDnK9e3BYzLfWyZMpmJv
	uP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=7ERydUb5GHs4SAo2aYRuYC3oG/4RIdFn+3ZEZt/VQL8=;
	b=EnvOqK6VHqwCr+bEEntxhKcHnV+M6VQrpt41oac7/+vzpZxW9g1s8hW7Ba1eEIKWhL
	A/6df5kJd3Jkgfy5KE7M2+W503FeCLWz4m5rvYOh7lY4xoshauSqPPzrfJ6REzaXQTQD
	HJeu/809MYid33ndNJOcIgtjIM27yzEPcdBSBigf2JVKJXZbrM2PGkR+19BU5luPXet4
	Dn9fOuJzg5BZBMr2P6pRyCRUNheYPupeJwsa/QNs4hxFWkc2r3vqOMaeYhbpLCza3SrS
	Ab0y3aOU9gH96rd2zsHmEYGKxDZPd0IGanI3deqzOzpv0/2Vs0gBEl0PzsvvmhSSIQnl
	pPkw==
X-Gm-Message-State: AD7BkJIxkUL40lUQFiawLREhmd232kR/7nr/cZjqewvWht7oVR7DEV0pzNoiPKBaDBqx9YJG
X-Received: by 10.66.192.195 with SMTP id hi3mr31329516pac.149.1459521779483; 
	Fri, 01 Apr 2016 07:42:59 -0700 (PDT)
Received: from [192.168.0.44]
	(host109-150-201-247.range109-150.btcentralplus.com.
	[109.150.201.247]) by smtp.googlemail.com with ESMTPSA id
	tn5sm21571116pac.32.2016.04.01.07.42.57
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 01 Apr 2016 07:42:58 -0700 (PDT)
To: Elliot Smith <elliot.smith@intel.com>, bitbake-devel@lists.openembedded.org
References: <1459511592-1641-1-git-send-email-elliot.smith@intel.com>
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <56FE88EF.5010201@intel.com>
Date: Fri, 1 Apr 2016 15:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1459511592-1641-1-git-send-email-elliot.smith@intel.com>
Subject: Re: [PATCH] toaster: buildinfohelper Create target list for all types of build
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
X-List-Received-Date: Fri, 01 Apr 2016 14:43:00 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/16 12:53, Elliot Smith wrote:
> From: Michael Wood <michael.g.wood@intel.com>
>
> Create the target list cache for command line builds and toaster
> triggered builds. This fixes a regression where the target is not
> identified as an image after building as the target cache is empty for
> toaster triggered builds
>
> [YOCTO #9266]
>
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>   bitbake/lib/bb/ui/buildinfohelper.py | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
> index 9021c63..7b8b1a5 100644
> --- a/bitbake/lib/bb/ui/buildinfohelper.py
> +++ b/bitbake/lib/bb/ui/buildinfohelper.py
> @@ -977,15 +977,16 @@ class BuildInfoHelper(object):
>           event: a TargetsAcquired event with a task property (e.g. "build")
>           and a targetsList property (e.g. ["zlib", "dropbear"])
>           """
> -        if self.internal_state['build'].project.is_default:
> -            targets = map(lambda target: target + ':' + event.task, event.targetsList)
> +        targets = map(lambda target: target + ':' + event.task,
> +                      event.targetsList)
>   
> -            target_information = {
> -              'targets': targets,
> -              'build': self.internal_state['build']
> -            }
> +        target_information = {
> +            'targets': targets,
> +            'build': self.internal_state['build']
> +        }
>   
> -            self.internal_state['targets'] = self.orm_wrapper.get_or_create_targets(target_information)
> +        self.internal_state['targets'] = \
> +            self.orm_wrapper.get_or_create_targets(target_information)
>   
>       def update_build(self, event):
>           """
This patch depends on:

10/03/16 13:57 - [PATCH] toaster: create Build object earlier in bitbake 
processing


