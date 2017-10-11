Return-Path: <jpuhlman@mvista.com>
Received: from mail-pg0-f43.google.com (mail-pg0-f43.google.com [74.125.83.43])
	by mail.openembedded.org (Postfix) with ESMTP id 4C48271CBD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Oct 2017 03:55:09 +0000 (UTC)
Received: by mail-pg0-f43.google.com with SMTP id k7so316541pga.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Oct 2017 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language;
	bh=2a6KpYXkmgflftBRb56BpblckENexF912u+eDP13uVE=;
	b=tQWW2OIOAj/2RPkgNHgNPDki0gj+jaQoUhIg1i8RACt+rF2/abRAzKaj9AyJWEs1YY
	6UuDcBJCcCIi84ImWwNKZ1u6OLhwf1Zdv0R1XHnTnw9vG8brrUZTJpTWhaKACE/6zsdW
	alPN9XrA3Hz7UEyhAFk580I8wafFf0XoXQdSA6j2LzBDtbl3G96huz8ad0cWvBCEmeAt
	S0Ne8JNaW9+V9/T41je31KmHYmQmySQgTHHGawmj6AWsnvJUOKx9kKbtzGzRT4ckDiFu
	YWHxLQF4pawI5olsfc1PGHBk9EK0pMN9AZ0bLlTavFSdlo61R/db2r1IyU6FKE8cRY9n
	nVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=2a6KpYXkmgflftBRb56BpblckENexF912u+eDP13uVE=;
	b=EvbKMkpa9iRMl0WoMwXUr9NcBSBDW/rxeeyIK+lONzL5kRl3dS4j4ympCxYQuiLeWw
	6DFGsTpAcK6PN1S2x3NscmvgA6DPmBgw/AbTCGqqz9NlhhYX9fC2EFfoGU1QkP8z1faV
	VqJxnz3s0NLCExmWUYKpFY+GkiNvTBZ0SW5w2u5lqjEBjVtPKmcA5ZlDD++zUL6yytl8
	byKvyrWE3ofxBwqXk4VU4+tISlO3RnykRC1D3B2q2ZXt7blbQToQaIlH1X6ji16m6lGD
	RK66BZkjmGVScsctTFtcxnv5ludkIRvS340kVWr1+t+x/I/2b9EQOdm7kShMqDH1SXO4
	kJeA==
X-Gm-Message-State: AMCzsaVwAIt2krQn4My3BdJgzP8Fu1Ykfnxxs8OClmvI9ioq4lF3UfDZ
	RjI9hWfGlnoQUMAsAIVskBKkt0bgnJg=
X-Google-Smtp-Source: AOwi7QDUPY+dKt5OdgrCx4i8VqtaGoLc/QE6y86ACLmYKZOF0sBuIz7Oiggvd9sZTPD9nHqGaePxxw==
X-Received: by 10.99.108.68 with SMTP id h65mr14138073pgc.1.1507694111340;
	Tue, 10 Oct 2017 20:55:11 -0700 (PDT)
Received: from [192.168.1.13] (99-0-9-164.lightspeed.frokca.sbcglobal.net.
	[99.0.9.164]) by smtp.gmail.com with ESMTPSA id
	o128sm18945413pga.5.2017.10.10.20.55.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 10 Oct 2017 20:55:10 -0700 (PDT)
To: Christopher Larson <kergoth@gmail.com>
References: <1507672037-29948-1-git-send-email-jpuhlman@mvista.com>
	<CABcZANkgVCzqE+me+R0TUp2G9fnR_ehCn0rM_XSCMQ2A0QNgWA@mail.gmail.com>
From: "Jeremy A. Puhlman" <jpuhlman@mvista.com>
Message-ID: <17d7f5f1-ccea-1419-6d73-66c2f9ff2668@mvista.com>
Date: Tue, 10 Oct 2017 20:55:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CABcZANkgVCzqE+me+R0TUp2G9fnR_ehCn0rM_XSCMQ2A0QNgWA@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] Allow layers to be added relative to topdir.
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
X-List-Received-Date: Wed, 11 Oct 2017 03:55:10 -0000
Content-Type: multipart/alternative;
	boundary="------------2B9B489B5FB0D8F515786815"
Content-Language: en-US

--------------2B9B489B5FB0D8F515786815
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/2017 6:57 PM, Christopher Larson wrote:
> I see no need for this patch:
>
> TOPDIR := '${@os.path.dirname(os.path.dirname(FILE))}'
> BBPATH = '${TOPDIR}'
> BBFILES = ''
> BBLAYERS = '\
>     ${TOPDIR}/poky/meta-yocto-bsp \
>     ${TOPDIR}/poky/meta-yocto \
>     ${TOPDIR}/poky/meta \
>     ${TOPDIR}/meta-oe/meta-oe \
> '

Yes. You can manually modify the file. However if you use bitbake-layers 
layerindex-fetch or bitbake layer-add, it is always absolute. OTOH, you 
could make the same argument for not needing "bitbake-layers add-layers 
"since you can also manually modify the file.

>
> On Tue, Oct 10, 2017 at 2:47 PM, Jeremy Puhlman <jpuhlman@mvista.com 
> <mailto:jpuhlman@mvista.com>> wrote:
>
>     From: "Jeremy A. Puhlman" <jpuhlman@mvista.com
>     <mailto:jpuhlman@mvista.com>>
>
>     Use case:
>     Some users place their projects and their layers under source control.
>     If absolute paths are used for the layers, the bblayers file is
>     invalid
>     when checked out on another system. If the layers are checked in
>     relative to the project, then the project can be used anywhere.
>
>     If LAYERS_RELATIVE is set in the bblayers.conf file, each layer is
>     added
>     relative to TOPDIR.
>
>     Signed-off-by: Jeremy Puhlman <jpuhlman@mvista.com
>     <mailto:jpuhlman@mvista.com>>
>     ---
>      lib/bblayers/action.py | 4 +++-
>      1 file changed, 3 insertions(+), 1 deletion(-)
>
>     diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
>     index b1326e5..4dc6622 100644
>     --- a/lib/bblayers/action.py
>     +++ b/lib/bblayers/action.py
>     @@ -38,7 +38,9 @@ class ActionPlugin(LayerPlugin):
>              tempdir = tempfile.mkdtemp()
>              backup = tempdir + "/bblayers.conf.bak"
>              shutil.copy2(bblayers_conf, backup)
>     -
>     +        if self.tinfoil.config_data.getVar('LAYERS_RELATIVE'):
>     +            topdir = self.tinfoil.config_data.getVar('TOPDIR')
>     +            layerdir = os.path.join("${TOPDIR}",
>     os.path.relpath(layerdir,topdir))
>              try:
>                  notadded, _ =
>     bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
>                  if not (args.force or notadded):
>     --
>     2.6.2
>
>     --
>     _______________________________________________
>     bitbake-devel mailing list
>     bitbake-devel@lists.openembedded.org
>     <mailto:bitbake-devel@lists.openembedded.org>
>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>     <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>
>
>
>
>
> -- 
> Christopher Larson
> kergoth at gmail dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Senior Software Engineer, Mentor Graphics

-- 
Jeremy A. Puhlman
jpuhlman@mvista.com


--------------2B9B489B5FB0D8F515786815
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 10/10/2017 6:57 PM, Christopher
      Larson wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CABcZANkgVCzqE+me+R0TUp2G9fnR_ehCn0rM_XSCMQ2A0QNgWA@mail.gmail.com">
      <div dir="ltr">I see no need for this patch:
        <div><br>
        </div>
        <div>
          <div>TOPDIR := '${@os.path.dirname(os.path.dirname(FILE))}'</div>
          <div>BBPATH = '${TOPDIR}'</div>
          <div>BBFILES = ''</div>
          <div>BBLAYERS = '\</div>
          <div>    ${TOPDIR}/poky/meta-yocto-bsp \<br>
          </div>
          <div>    ${TOPDIR}/poky/meta-yocto \</div>
          <div>    ${TOPDIR}/poky/meta \</div>
          <div>    ${TOPDIR}/meta-oe/meta-oe \</div>
          <div>'</div>
        </div>
      </div>
    </blockquote>
    <br>
    Yes. You can manually modify the file. However if you use
    bitbake-layers layerindex-fetch or bitbake layer-add, it is always
    absolute. OTOH, you could make the same argument for not needing
    "bitbake-layers add-layers "since you can also manually modify the
    file.<br>
    <br>
    <blockquote type="cite"
cite="mid:CABcZANkgVCzqE+me+R0TUp2G9fnR_ehCn0rM_XSCMQ2A0QNgWA@mail.gmail.com">
      <div dir="ltr">
        <div>
          <div class="gmail_extra"><br>
            <div class="gmail_quote">On Tue, Oct 10, 2017 at 2:47 PM,
              Jeremy Puhlman <span dir="ltr">&lt;<a
                  href="mailto:jpuhlman@mvista.com" target="_blank"
                  moz-do-not-send="true">jpuhlman@mvista.com</a>&gt;</span>
              wrote:<br>
              <blockquote class="gmail_quote" style="margin:0px 0px 0px
0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">From:
                "Jeremy A. Puhlman" &lt;<a
                  href="mailto:jpuhlman@mvista.com"
                  moz-do-not-send="true">jpuhlman@mvista.com</a>&gt;<br>
                <br>
                Use case:<br>
                Some users place their projects and their layers under
                source control.<br>
                If absolute paths are used for the layers, the bblayers
                file is invalid<br>
                when checked out on another system. If the layers are
                checked in<br>
                relative to the project, then the project can be used
                anywhere.<br>
                <br>
                If LAYERS_RELATIVE is set in the bblayers.conf file,
                each layer is added<br>
                relative to TOPDIR.<br>
                <br>
                Signed-off-by: Jeremy Puhlman &lt;<a
                  href="mailto:jpuhlman@mvista.com"
                  moz-do-not-send="true">jpuhlman@mvista.com</a>&gt;<br>
                ---<br>
                 lib/bblayers/action.py | 4 +++-<br>
                 1 file changed, 3 insertions(+), 1 deletion(-)<br>
                <br>
                diff --git a/lib/bblayers/action.py
                b/lib/bblayers/action.py<br>
                index b1326e5..4dc6622 100644<br>
                --- a/lib/bblayers/action.py<br>
                +++ b/lib/bblayers/action.py<br>
                @@ -38,7 +38,9 @@ class ActionPlugin(LayerPlugin):<br>
                         tempdir = tempfile.mkdtemp()<br>
                         backup = tempdir + "/bblayers.conf.bak"<br>
                         shutil.copy2(bblayers_conf, backup)<br>
                -<br>
                +        if self.tinfoil.config_data.<wbr>getVar('LAYERS_RELATIVE'):<br>
                +            topdir = self.tinfoil.config_data.<wbr>getVar('TOPDIR')<br>
                +            layerdir = os.path.join("${TOPDIR}",
                os.path.relpath(layerdir,<wbr>topdir))<br>
                         try:<br>
                             notadded, _ = bb.utils.edit_bblayers_conf(<wbr>bblayers_conf,
                layerdir, None)<br>
                             if not (args.force or notadded):<br>
                <span class="gmail-HOEnZb"><font color="#888888">--<br>
                    2.6.2<br>
                    <br>
                    --<br>
                    ______________________________<wbr>_________________<br>
                    bitbake-devel mailing list<br>
                    <a
                      href="mailto:bitbake-devel@lists.openembedded.org"
                      moz-do-not-send="true">bitbake-devel@lists.<wbr>openembedded.org</a><br>
                    <a
                      href="http://lists.openembedded.org/mailman/listinfo/bitbake-devel"
                      rel="noreferrer" target="_blank"
                      moz-do-not-send="true">http://lists.openembedded.org/<wbr>mailman/listinfo/bitbake-devel</a><br>
                  </font></span></blockquote>
            </div>
            <br>
            <br clear="all">
            <div><br>
            </div>
            -- <br>
            <div class="gmail_signature">
              <div dir="ltr">
                <div>
                  <div dir="ltr">Christopher Larson<br>
                    kergoth at gmail dot com<br>
                    Founder - BitBake, OpenEmbedded, OpenZaurus<br>
                    Senior Software Engineer, Mentor Graphics</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 
Jeremy A. Puhlman
<a class="moz-txt-link-abbreviated" href="mailto:jpuhlman@mvista.com">jpuhlman@mvista.com</a>
</pre>
  </body>
</html>

--------------2B9B489B5FB0D8F515786815--
