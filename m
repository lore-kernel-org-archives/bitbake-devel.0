Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web12.905.1592456090380156013
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Jun 2020 21:54:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=kBRCsW57;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: alhe@linux.microsoft.com)
Received: from [192.168.1.246] (cpe-68-201-52-49.elp.res.rr.com [68.201.52.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C03520B4781;
	Wed, 17 Jun 2020 21:54:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C03520B4781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1592456089;
	bh=eIfvyLv8swwAAK1YgujNYyPt/Pu3SPL7c/hAvj71dhQ=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=kBRCsW57BiPwO94kOS7FCz3exRPgSz1fVmcjHUjddcg0TtkA/0jiR2bX/4we75+HH
	 fMZWd6GqY9v5u67SMzPxg4xJDt2vwNN/6ngucTmBlIfe1DR3Qd62S/miaGPJj3UQ6H
	 w5LQA45OTm8hjS9VaH/wpflAG5qrv4pLjSDUVizc=
Subject: Re: [bitbake-devel] Python package with optional dependencies
To: jocelyn.kevorkian@gmail.com, bitbake-devel@lists.openembedded.org
References: <LqWJ.1592405996254748693.FRdz@lists.openembedded.org>
From: "Alejandro Hernandez" <alhe@linux.microsoft.com>
Message-ID: <97706690-0195-8b3d-ca06-ba7c50b8fda4@linux.microsoft.com>
Date: Wed, 17 Jun 2020 21:54:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <LqWJ.1592405996254748693.FRdz@lists.openembedded.org>
Content-Type: multipart/alternative;
 boundary="------------0C2854E155968174884C72A2"
Content-Language: en-US

--------------0C2854E155968174884C72A2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The meta-openembedded mailing list 
(openembedded-devel@lists.openembedded.org [meta-python]) would be the 
proper place to find an answer to your question, also, joining the 
#yocto and #oe channels on IRC would allow you to ask questions there, 
that being said, there is a python3-jsonrpcserver recipe on the 
meta-python layer: 
https://layers.openembedded.org/layerindex/recipe/113715/ ,although you 
are looking for the client, that might be a good starting point, by the 
way, optional dependencies are usually set by PACKAGECONFIGs: 
https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#var-PACKAGECONFIG

And you probably will have to play around with the setuptools3 class to 
achieve that.

Cheers,

Alejandro

On 6/17/20 7:59 AM, jocelyn.kevorkian@gmail.com wrote:
> Hello guys,
>
> I would like to use on my target a python package which has optional 
> dependencies, it is jsonrpcclients, for instance to use it with zero 
> mq you have to install it like this : pip install jsonrpcclients[pyzmq]
>
> I have no idea how to deal with this syntax, could you help me please ?
>
> Thanks !
>
> 

--------------0C2854E155968174884C72A2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello,</p>
    <p>The meta-openembedded mailing list
      (<a class="moz-txt-link-abbreviated" href="mailto:openembedded-devel@lists.openembedded.org">openembedded-devel@lists.openembedded.org</a> [meta-python]) would be
      the proper place to find an answer to your question, also, joining
      the #yocto and #oe channels on IRC would allow you to ask
      questions there, that being said, there is a python3-jsonrpcserver
      recipe on the meta-python layer: <a
        href="https://layers.openembedded.org/layerindex/recipe/113715/">https://layers.openembedded.org/layerindex/recipe/113715/</a>
      ,although you are looking for the client, that might be a good
      starting point, by the way, optional dependencies are usually set
      by PACKAGECONFIGs: <a
href="https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#var-PACKAGECONFIG">https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#var-PACKAGECONFIG</a></p>
    <p>And you probably will have to play around with the setuptools3
      class to achieve that.<br>
    </p>
    <p>Cheers,</p>
    <p>Alejandro<br>
    </p>
    <div class="moz-cite-prefix">On 6/17/20 7:59 AM,
      <a class="moz-txt-link-abbreviated" href="mailto:jocelyn.kevorkian@gmail.com">jocelyn.kevorkian@gmail.com</a> wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:LqWJ.1592405996254748693.FRdz@lists.openembedded.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      Hello guys,<br>
      <br>
      I would like to use on my target a python package which has
      optional dependencies, it is jsonrpcclients, for instance to use
      it with zero mq you have to install it like this : pip install
      jsonrpcclients[pyzmq] <br>
      <br>
      I have no idea how to deal with this syntax, could you help me
      please ?<br>
      <br>
      Thanks !
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------0C2854E155968174884C72A2--
