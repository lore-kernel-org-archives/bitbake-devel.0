Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jpuhlman@mvista.com>) id 1SHdmW-0008CS-I8
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Apr 2012 18:19:00 +0200
Received: by pbcum15 with SMTP id um15so132553pbc.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2012 09:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:x-enigmail-version:content-type
	:content-transfer-encoding:x-gm-message-state;
	bh=LcQGRxjvnpht53VPn7BlKy88NXwvA09SCYNNzcp05nM=;
	b=ap+ipzlxu/s30XmenW4r6mKZj0E673mrL/k8N8PC2Ry2RMCC15XFcSxoKxPrrtFmHd
	mF5UpLltvYEVHfCm6d11haXzmQs2z8v/HkWxE/X5f9FDyS4cx2XF1bXGng3AEeLz4L+0
	rbAgNy/hGXU5UE5X/R9+lRHHgHiDqBFFgnDx/D2j0TcfaqS7o8z2zV/KB+TJheaYER1Y
	ZbR/IpElndVbW+AzXVoXCUg8PqNk+T0AziZlpdyp8jBubCY0/jrb/GGq2Sp7Hn1Im0FF
	PTJzASUnFRBHlY5fMyPATyycSCS4XrZgC/Qv7mAE+lfZjrtF9E3s/db9DCaYsXYthsc2
	HMBQ==
Received: by 10.68.221.227 with SMTP id qh3mr29901797pbc.43.1334074181579;
	Tue, 10 Apr 2012 09:09:41 -0700 (PDT)
Received: from [192.168.1.4] (c-76-20-107-156.hsd1.ca.comcast.net.
	[76.20.107.156])
	by mx.google.com with ESMTPS id t5sm223644pbm.64.2012.04.10.09.09.38
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Apr 2012 09:09:39 -0700 (PDT)
Message-ID: <4F845B40.2040302@mvista.com>
Date: Tue, 10 Apr 2012 09:09:36 -0700
From: Jeremy Puhlman <jpuhlman@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: Khem Raj <raj.khem@gmail.com>
References: <4F82DE2E.30208@mlbassoc.com>
	<CAMKF1sr5t8DptrHBO6NdA0mh2URs6QVXgpfLSXMcFHW9ybX3jg@mail.gmail.com>
In-Reply-To: <CAMKF1sr5t8DptrHBO6NdA0mh2URs6QVXgpfLSXMcFHW9ybX3jg@mail.gmail.com>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQn15WiqrxGl9Pq1iZGW/PU0JSYul/sAczJ4QuTIvZ3dYE2iDQ19yrmUn0Q6GwaKByWFGWjG
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bblayers.conf is required?
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
X-List-Received-Date: Tue, 10 Apr 2012 16:19:00 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/2012 11:07 AM, Khem Raj wrote:
> On Mon, Apr 9, 2012 at 6:03 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>> The config file conf/bblayers.conf seems to be required:
>>  $ bitbake core-image-minimal
>>  Unable to find conf/bblayers.conf
>>  BitBake must be run from within your build directory: /home/local/p60_poky
>>
>> but the bitbake documentation says otherwise:
>>                <para>BitBake will first search the current working directory
>> for an optional "conf/bblayers.conf" configuration file. This file is
>> expected to contain a BBLAYERS variable which is a space delimited list of
>> 'layer' directories. For each directory in this list, a "conf/layer.conf"
>> file will be searched for and parsed with the LAYERDIR variable being set to
>> the directory where the layer was found. The idea is these files will setup
>> BBPATH and other variables correctly for a given build directory
>> automatically for the user.</para>
>>
>> Maybe the documentation should just read "required" instead of "optional"?
> 
> I think yes. Next action is a patch or bug report.

Hmmm you used to be able to run bitbake by just setting the BBPATH
variable in the environment, and not need a bblayers file. It is not the
suggested use case anymore, but looking at cooker I don't see anything
in there in the layer handling code that would preclude that use.

Also that final error message comes from the content bitbake script not
bitbake proper.

-- 
Jeremy Puhlman
Montavista Software, LLC.


