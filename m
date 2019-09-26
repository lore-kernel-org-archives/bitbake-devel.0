Return-Path: <jpuhlman@mvista.com>
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
	[209.85.210.48])
	by mail.openembedded.org (Postfix) with ESMTP id 436EA7EE4F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 21:00:50 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id 21so369675otj.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-language;
	bh=k/dcURxDiSkILveB/XHAp0/EndpPm081uvBDjvKTspQ=;
	b=xsJ1vLrEr7caFMsP6l8fXR84+xbKxVnD3UpUDv/H1OEi7vafCYYer6fw4POXx7io66
	ItoPlAsUuE50pKj09Ddhvkvc+N1mL89IcoX3UeqlbIO78yIOzSQplOp2dTTf5rkrUyJv
	kDdRuZG22jgw0Voc+5Eo8ju3fSYiZRJ2n0faYhmsWTtmM34W6vDplAhFVylGzIL9S83r
	/oGA7d/LlmX3cwutNJeJpbe0Fm0VSuXeR94xgAftDyNv/zLt1bprHKcumHaiWNQPMRNz
	esFcL7EcDrntGg0GRMuphFUmCaIUNVIlg3dTLB/IrNQG6OJVXSh5Y+3nTvvTOQpaAINP
	7tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=k/dcURxDiSkILveB/XHAp0/EndpPm081uvBDjvKTspQ=;
	b=T8mSICc6ZrF4BOR69M40L7iy4FT7CXhiN9vPofgw8PSC6oJW1qBSvnQ+XsBRkRmwiN
	X+ajpgohyA/tFeN1veCmmkjlZTNR/CRSKPIu4KPtjuWxjz6u5KK8VztlgU3XS7Vra40C
	abZmttqeF6cWFre8GXTD3sO/YPFh2YYSe/tK19zm0Co4SuRJWOyG8eYFFQdznvcz0JPj
	AOQdmx+3sZGxcquJh33ljxSesOUFnKVnRF6FfQ5gPlj3lLdzDBSYGJKIBFjKZD10ka+0
	xhCgEoQnpY9tfI3RldMBOl34R8ut/XYzkdFJ8RIGSWfnuXjKcDJa2elMObB8A10Ail7n
	dZ4Q==
X-Gm-Message-State: APjAAAWx36YOwWwcUkjapY+KkvBSTnjMz6PpAqgimv7ZKszPZkBCdD3q
	1PYt/7cLV/mdHIILJQTU74qlug==
X-Google-Smtp-Source: APXvYqwfcyIc2vpsw3bWPFMjbxZfIaSf6zuPmSINLL7iniONoJL8FEBNNgAywO9hZBJzsWb6zavpYA==
X-Received: by 2002:a9d:6305:: with SMTP id q5mr562099otk.102.1569531650989;
	Thu, 26 Sep 2019 14:00:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:4c90:60a0:8460:5454:270e:1a37?
	([2600:1700:4c90:60a0:8460:5454:270e:1a37])
	by smtp.gmail.com with ESMTPSA id
	x140sm1031850oix.42.2019.09.26.14.00.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Sep 2019 14:00:49 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org, grzegorz.heldt@gmail.com
References: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
From: "Jeremy A. Puhlman" <jpuhlman@mvista.com>
Message-ID: <d6a33b15-e28a-b2b8-3359-8c4b38afe5eb@mvista.com>
Date: Thu, 26 Sep 2019 14:00:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
Subject: Re: bitbake-layers add-layer issue
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
X-List-Received-Date: Thu, 26 Sep 2019 21:00:50 -0000
Content-Type: multipart/alternative;
	boundary="------------3D0A6F80EA70CBCDA1995CA4"
Content-Language: en-US

--------------3D0A6F80EA70CBCDA1995CA4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/25/2019 1:38 PM, Grzegorz Heldt wrote:
> Hello.
>
> To setup my projects im usually using bash scripts like that performs 
> following steps:
>
> -------------------------------
> wiesniak@desk:~/projects/yocto-rasp/poky/build/conf$ cat ../../../setup
> #!/bin/bash
>
> BRANCH=warrior
> git clone git://git.yoctoproject.org/meta-raspberrypi 
> <http://git.yoctoproject.org/meta-raspberrypi> -b $BRANCH
> git clone git://git.yoctoproject.org/poky 
> <http://git.yoctoproject.org/poky> -b $BRANCH
> git clone git://git.openembedded.org/meta-openembedded 
> <http://git.openembedded.org/meta-openembedded> -b $BRANCH
>
> cd poky
> . oe-init-build-env
> bitbake-layers add-layer ../../meta-raspberrypi/
> bitbake-layers add-layer ../../meta-openembedded/meta-python/
> bitbake-layers add-layer ../../meta-openembedded/meta-oe/
> bitbake-layers add-layer ../../meta-openembedded/meta-multimedia/
> bitbake-layers add-layer ../../meta-openembedded/meta-networking/
>
> echo INHERIT += \"rm_work\" >> conf/local.conf
> echo DL_DIR = \"/home/yocto-downloads\" >> conf/local.conf
>
You need to add meta-oe before meta-python since meta-python depends on 
it. Once meta-python is added bitbake the next add
fail because it cannot satisfy the meta-oe requirement. The error is not 
really helpful.

This is what you get on thud.

[cluge@jptest01 build]$ bitbake-layers add-layer 
../meta-openembedded/meta-python/
NOTE: Starting bitbake server...
[cluge@jptest01 build]$ bitbake-layers add-layer 
../meta-openembedded/meta-oe/
NOTE: Starting bitbake server...
Traceback (most recent call last):
   File 
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/bin/bitbake-layers", 
line 103, in <module>
     ret = main()
   File 
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/bin/bitbake-layers", 
line 71, in main
     tinfoil.prepare(True)
   File 
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/tinfoil.py", 
line 418, in prepare
     self.run_command('parseConfiguration')
   File 
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/tinfoil.py", 
line 476, in run_command
     raise TinfoilCommandFailed(result[1])
bb.tinfoil.TinfoilCommandFailed: Traceback (most recent call last):
   File 
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/command.py", 
line 84, in runCommand
     result = command_method(self, commandline)
   File 
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/command.py", 
line 285, in parseConfiguration
     command.cooker.parseConfiguration()
   File 
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/cooker.py", 
line 438, in parseConfiguration
     self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
   File 
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/cooker.py", 
line 1232, in handleCollections
     raise CollectionError("Errors during parsing layer configuration")
bb.cooker.CollectionError: Errors during parsing layer configuration
>
>
> <http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=emailclient> 
> 	Virus-free. www.avg.com 
> <http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=emailclient> 
>
>
> <#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>
>

-- 
Jeremy A. Puhlman
jpuhlman@mvista.com


--------------3D0A6F80EA70CBCDA1995CA4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 9/25/2019 1:38 PM, Grzegorz Heldt
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">Hello.
        <div><br>
        </div>
        <div>To setup my projects im usually using bash scripts like
          that performs following steps:</div>
        <div><br>
        </div>
        <div>-------------------------------</div>
        <div>wiesniak@desk:~/projects/yocto-rasp/poky/build/conf$ cat
          ../../../setup <br>
          #!/bin/bash<br>
          <br>
          BRANCH=warrior<br>
          git clone git://<a
            href="http://git.yoctoproject.org/meta-raspberrypi"
            moz-do-not-send="true">git.yoctoproject.org/meta-raspberrypi</a>
          -b $BRANCH<br>
          git clone git://<a href="http://git.yoctoproject.org/poky"
            moz-do-not-send="true">git.yoctoproject.org/poky</a> -b
          $BRANCH<br>
          git clone git://<a
            href="http://git.openembedded.org/meta-openembedded"
            moz-do-not-send="true">git.openembedded.org/meta-openembedded</a>
          -b $BRANCH<br>
          <br>
          cd poky<br>
          . oe-init-build-env<br>
          bitbake-layers add-layer ../../meta-raspberrypi/<br>
          bitbake-layers add-layer ../../meta-openembedded/meta-python/<br>
          bitbake-layers add-layer ../../meta-openembedded/meta-oe/<br>
          bitbake-layers add-layer
          ../../meta-openembedded/meta-multimedia/<br>
          bitbake-layers add-layer
          ../../meta-openembedded/meta-networking/<br>
          <br>
        </div>
        <div>echo INHERIT += \"rm_work\" &gt;&gt; conf/local.conf<br>
          echo DL_DIR = \"/home/yocto-downloads\" &gt;&gt;
          conf/local.conf<br>
          <br>
        </div>
      </div>
    </blockquote>
    You need to add meta-oe before meta-python since meta-python depends
    on it. Once meta-python is added bitbake the next add <br>
    fail because it cannot satisfy the meta-oe requirement. The error is
    not really helpful.<br>
    <br>
    This is what you get on thud.<br>
    <br>
    [cluge@jptest01 build]$ bitbake-layers add-layer
    ../meta-openembedded/meta-python/<br>
    NOTE: Starting bitbake server...<br>
    [cluge@jptest01 build]$ bitbake-layers add-layer
    ../meta-openembedded/meta-oe/<br>
    NOTE: Starting bitbake server...<br>
    Traceback (most recent call last):<br>
      File
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/bin/bitbake-layers",
    line 103, in &lt;module&gt;<br>
        ret = main()<br>
      File
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/bin/bitbake-layers",
    line 71, in main<br>
        tinfoil.prepare(True)<br>
      File
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/tinfoil.py",
    line 418, in prepare<br>
        self.run_command('parseConfiguration')<br>
      File
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/tinfoil.py",
    line 476, in run_command<br>
        raise TinfoilCommandFailed(result[1])<br>
    bb.tinfoil.TinfoilCommandFailed: Traceback (most recent call last):<br>
      File
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/command.py",
    line 84, in runCommand<br>
        result = command_method(self, commandline)<br>
      File
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/command.py",
    line 285, in parseConfiguration<br>
        command.cooker.parseConfiguration()<br>
      File
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/cooker.py",
    line 438, in parseConfiguration<br>
        self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))<br>
      File
"/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/cooker.py",
    line 1232, in handleCollections<br>
        raise CollectionError("Errors during parsing layer
    configuration")<br>
    bb.cooker.CollectionError: Errors during parsing layer configuration
    <blockquote type="cite"
cite="mid:CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
      </div>
      <div id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br>
        <table style="border-top: 1px solid #D3D4DE;">
          <tbody>
            <tr>
              <td style="width: 55px; padding-top: 13px;"><a
href="http://www.avg.com/email-signature?utm_medium=email&amp;utm_source=link&amp;utm_campaign=sig-email&amp;utm_content=emailclient"
                  target="_blank" moz-do-not-send="true"><img
src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
                    alt="" style="width: 46px; height: 29px;"
                    moz-do-not-send="true" width="46" height="29"></a></td>
              <td style="width: 470px; padding-top: 12px; color:
                #41424e; font-size: 13px; font-family: Arial, Helvetica,
                sans-serif; line-height: 18px;">Virus-free. <a
href="http://www.avg.com/email-signature?utm_medium=email&amp;utm_source=link&amp;utm_campaign=sig-email&amp;utm_content=emailclient"
                  target="_blank" style="color: #4453ea;"
                  moz-do-not-send="true">www.avg.com</a> </td>
            </tr>
          </tbody>
        </table>
        <a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
          height="1" moz-do-not-send="true"> </a></div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 
Jeremy A. Puhlman
<a class="moz-txt-link-abbreviated" href="mailto:jpuhlman@mvista.com">jpuhlman@mvista.com</a>
</pre>
  </body>
</html>

--------------3D0A6F80EA70CBCDA1995CA4--
