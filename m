Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6DAF273D53
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Apr 2015 10:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3HAgE5X004806; Fri, 17 Apr 2015 11:42:14 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PLThfQDlCkHV; Fri, 17 Apr 2015 11:42:14 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3HAfvDS004802
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 Apr 2015 11:42:08 +0100
Message-ID: <1429267317.6976.196.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Date: Fri, 17 Apr 2015 11:41:57 +0100
In-Reply-To: <1429208939-10876-1-git-send-email-ed.bartosh@linux.intel.com>
References: <CABcZANnOghZ-ek19v0KH8L2EdC1m2vDOW2Eyv_zOV2zfFaLnWg@mail.gmail.com>
	<1429208939-10876-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: Allow ~ in bblayers
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
X-List-Received-Date: Fri, 17 Apr 2015 10:42:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-04-16 at 21:28 +0300, Ed Bartosh wrote:
> Implemented processing of ~ in bblayer's paths if HOME
> environment variable is approved.
> 
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  bitbake/lib/bb/cookerdata.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
> index 6c11a60..bf08c63 100644
> --- a/bitbake/lib/bb/cookerdata.py
> +++ b/bitbake/lib/bb/cookerdata.py
> @@ -269,8 +269,11 @@ class CookerDataBuilder(object):
>              layers = (data.getVar('BBLAYERS', True) or "").split()
>  
>              data = bb.data.createCopy(data)
> +            approved = bb.utils.approved_variables()
>              for layer in layers:
>                  parselog.debug(2, "Adding layer %s", layer)
> +                if 'HOME' in approved:

can we change this to 

if 'HOME' in approved and '~' in layer:

simply so that we can more easily remember what this code is doing in
the future?

Cheers,

Richard

> +                    layer = os.path.expanduser(layer)
>                  data.setVar('LAYERDIR', layer)
>                  data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
>                  data.expandVarref('LAYERDIR')
> -- 
> 2.1.4
> 



