Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id B608760232
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Nov 2015 17:38:03 +0000 (UTC)
Received: by wmff134 with SMTP id f134so66886869wmf.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 Nov 2015 09:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel_com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-type:content-transfer-encoding;
	bh=6kBvp3mBM/s44Pox5sepKEcdnhv1Ry2/n893WTqj30s=;
	b=VpTGLVn0GNCCbluoYZmrrMNs8UD7i9myG5QgC3HTao95aOWfGKv8pAsd+7ZLcHasi7
	v6Rr0Sl3EtzTYKnhJmBdo3dma1XaiF+HGlXQynKYrnB7WAlEIvs04JQbANpfFrKZwF9y
	bvkHGURCekUaqV8zoAfi0++m4m0qbabyAjL74GcLb1TrmgNngY5yLVZSgZjltWyHMwZR
	Z4dt7iiRxhAeRKie9629jxPqqQfGeKrsWpMotzO6eiIKwmvhHH9N+hE4CP+qVRl3lWcU
	JbDIwiBVrIKsa0DF18UVe4e+3Rwh5YVcktt/7Q6dfpedtMRTy6KD3vD7C6hlFV2KDqXC
	4iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-type
	:content-transfer-encoding;
	bh=6kBvp3mBM/s44Pox5sepKEcdnhv1Ry2/n893WTqj30s=;
	b=cZN8k5cAAYZgL7QMay6HnAcEnEJEclfr1FwwuEGJXnO7qTQAzXW0wMJBszZH946eif
	UCGS8yORiMGP7Rp5Vm7QiIC8ZrEAN75myZuP5cGqcretMkVBr/eRyIvWBDDtZuZQNDqV
	nVpkp66to0whezHldRUWqxb8S4W/PNiWpkXGJRN54cm50IOV1kZSyfdeNIq5Ry44ZXpt
	nfPrFPkjURpLbIwlgMH0YnUprrWoZtciAbHRfrGjBE0h08IEFTBklhid+nVIm5w3xia2
	ro70Xf51QaCpH11imTUmvt2gx0Z+QfBk0kGK8JT6ZAUJ6UE3LMMjOc4xxBIwCFx+kfVM
	socg==
X-Gm-Message-State: ALoCoQkO0uRbm4GG0c+gdN23wEkfQSZNr84BaVpe94y4kKhfLDGVx2F1AplA+ChLXxBSXvoHx9iw
X-Received: by 10.28.92.16 with SMTP id q16mr16249627wmb.94.1446485883879;
	Mon, 02 Nov 2015 09:38:03 -0800 (PST)
Received: from [192.168.0.22] ([2.120.70.166])
	by smtp.googlemail.com with ESMTPSA id
	e9sm23474682wjw.8.2015.11.02.09.38.03
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 02 Nov 2015 09:38:03 -0800 (PST)
To: bitbake-devel@lists.openembedded.org
References: <B267CE46C9DC3C4BB251EC9C004EA5661A6925C3@HIKAWSEXMB01.ad.harman.com>
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <56379F7A.1070502@intel.com>
Date: Mon, 2 Nov 2015 17:38:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <B267CE46C9DC3C4BB251EC9C004EA5661A6925C3@HIKAWSEXMB01.ad.harman.com>
Subject: Re: Help
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
X-List-Received-Date: Mon, 02 Nov 2015 17:38:05 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/11/15 08:22, Almeida, Gabriel wrote:
>
> Hello there,
>
> I want to setup toaster on my VM and I have followed the steps up to 
> (3.1.1 - Step 5):
>
> https://www.yoctoproject.org/docs/1.9/toaster-manual/toaster-manual.html#setting-up-locally-and-running-in-analysis-mode
>
> Where I got the following error...
>
> Toaster is already running and I am able to access it over the web 
> (localhost:8000), however while bitbaking, I am getting the following 
> error:
>
> ```
>
> (venv)yoctoadm@kickseed:~/poky/build (fido)*$ bitbake core-image-minimal
>
> Traceback (most recent call last):
>
>   File "/home/yoctoadm/poky/bitbake/bin/bitbake", line 41, in <module>
>
> cookerdata.CookerConfiguration())
>
>   File "/home/yoctoadm/poky/bitbake/lib/bb/main.py", line 383, in 
> bitbake_main
>
>     return ui_module.main(server_connection.connection, 
> server_connection.events, configParams)
>
>   File "/home/yoctoadm/poky/bitbake/lib/bb/ui/knotty.py", line 287, in 
> main
>
> params.updateToServer(server, os.environ.copy())
>
>   File "/home/yoctoadm/poky/bitbake/lib/bb/cookerdata.py", line 79, in 
> updateToServer
>
>     ret, error = server.runCommand(["updateConfig", options, environment])
>
>   File "/usr/lib/python2.7/xmlrpclib.py", line 1233, in __call__
>
>     return self.__send(self.__name, args)
>
>   File "/usr/lib/python2.7/xmlrpclib.py", line 1587, in __request
>
> verbose=self.__verbose
>
>   File "/usr/lib/python2.7/xmlrpclib.py", line 1273, in request
>
>     return self.single_request(host, handler, request_body, verbose)
>
>   File "/usr/lib/python2.7/xmlrpclib.py", line 1306, in single_request
>
>     return self.parse_response(response)
>
>   File "/usr/lib/python2.7/xmlrpclib.py", line 1482, in parse_response
>
>     return u.close()
>
>   File "/usr/lib/python2.7/xmlrpclib.py", line 794, in close
>
>     raise Fault(**self._stack[0])
>
> Fault: <Fault 1: "<class 'xml.parsers.expat.ExpatError'>:not 
> well-formed (invalid token): line 115, column 120">
>
> ```
>

Is there anything in your environment/configuration which may mean that 
invalid characters for XML are trying to be written? Such as control 
characters?

Michael



