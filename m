Received: from mail-la0-f49.google.com ([209.85.215.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martiert@gmail.com>) id 1Tv2pd-0003tU-Os
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 Jan 2013 10:29:31 +0100
Received: by mail-la0-f49.google.com with SMTP id fk20so4726015lab.22
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2013 01:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:message-id:date:from:user-agent:mime-version:to:cc
	:subject:references:in-reply-to:content-type;
	bh=0r013GA658ldEqUf99QNgDE2kay/pei/27vrGPl35YY=;
	b=QbnnrQ8SdtveDD2LfDHpo/VQ+A3f5d0G+833r/Xg/HnO9JCHIEym1p8nDVkt6KcE8i
	uLg0zOh0zbsFscU/QOIOPUED7sVvmtd93XzGQcPukgTfWcvGna3GtFedRqdhVwEaiAVP
	MzuYmvhVvwyDZjW8dsz0c1/I1oSauH9NkiQAb5Q/+SAaNY7EvgOXlqC0JGcWIO3bTzrv
	H01ZYU14CrFLdwFI8CbdMhHfddZujDEfOtv+fqsg7TmXdYGsnWILP5ctfwcx57De0XST
	9qmcsx9iX7U78jQp3RKH+v/RmlbXI9XOUfJJ+EPtWswy7BcbKvC7CeXXJCaA8/tZP/EF
	lcjA==
X-Received: by 10.112.39.129 with SMTP id p1mr36351509lbk.26.1358241241583;
	Tue, 15 Jan 2013 01:14:01 -0800 (PST)
Received: from [10.54.86.72] (64-103-25-233.cisco.com. [64.103.25.233])
	by mx.google.com with ESMTPS id v7sm6399043lbj.13.2013.01.15.01.13.59
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 15 Jan 2013 01:14:00 -0800 (PST)
Message-ID: <50F51DD6.2040602@gmail.com>
Date: Tue, 15 Jan 2013 10:13:58 +0100
From: Martin Ertsaas <martiert@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.11) Gecko/20121128 Thunderbird/10.0.11
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <1357807596-31587-1-git-send-email-martiert@gmail.com>
	<CABcZANkgffV7FwXX4NVyBA2mm1YOg+1en9x_oidsey+AkqdGBg@mail.gmail.com>
	<CABcZAN=_k4LrYhi8_t35pQ3mkToJKCLO9FxKGoFQ9fB+8+M5Vg@mail.gmail.com>
	<CABcZANnD8C4gZXEcRWfR8f_ftZjndOT9UJ5796SEigRqw6tohA@mail.gmail.com>
In-Reply-To: <CABcZANnD8C4gZXEcRWfR8f_ftZjndOT9UJ5796SEigRqw6tohA@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils.py: Use shutil.rmtree if the path we wish to remove is a directory.
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
X-List-Received-Date: Tue, 15 Jan 2013 09:29:31 -0000
Content-Type: multipart/alternative;
	boundary="------------030208060209020003060206"

--------------030208060209020003060206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/13 15:18, Chris Larson wrote:
>
> On Thu, Jan 10, 2013 at 7:11 AM, Chris Larson <clarson@kergoth.com
> <mailto:clarson@kergoth.com>> wrote:
>
>
>     On Thu, Jan 10, 2013 at 7:10 AM, Chris Larson <clarson@kergoth.com
>     <mailto:clarson@kergoth.com>> wrote:
>
>         On Thu, Jan 10, 2013 at 1:46 AM, Martin Ertsaas
>         <martiert@gmail.com <mailto:martiert@gmail.com>> wrote:
>
>             On mac, os.unlink does not remove directories, and we
>             therefor have
>             to explicitly use shutil.rmtree if the path is a directory.
>             ---
>              lib/bb/utils.py |    5 ++++-
>              1 file changed, 4 insertions(+), 1 deletion(-)
>
>             diff --git a/lib/bb/utils.py b/lib/bb/utils.py
>             index cef0fdd..8b6d3f5 100644
>             --- a/lib/bb/utils.py
>             +++ b/lib/bb/utils.py
>             @@ -561,7 +561,10 @@ def remove(path, recurse=False):
>                  import os, errno, shutil, glob
>                  for name in glob.glob(path):
>                      try:
>             -            os.unlink(name)
>             +            if os.path.isdir(name):
>             +                shutil.rmtree(name)
>             +            else:
>             +                os.unlink(name)
>                      except OSError as exc:
>                          if recurse and exc.errno == errno.EISDIR:
>                              shutil.rmtree(name)
>
>
>
>         Look 2 lines down, where it checks to see if the os.unlink
>         failed due to it being a directory and runs shutil.rmtree if
>         that's the case.
>
>
>     I'm guessing you're trying to use it without passing recurse=True.
>
>
> Having through about it further, I think it might be best to be alter
> the code to also handle the case where recurse==False and the path is
> a directory by calling os.rmdir(). Perhaps this would reduce confusion.
> -- 
> Christopher Larson
You think to recursively call remove on the children of the directory?
Wouldn't something like:

for name in glob.glob(path):
    if os.path.isdir(name) and recurse:
        shutil.rmtree(name)
    elif os.path.isdir(name):
        os.rmdir(name)
    else:
        os.unlink(name)

Then we will possibly get an exception from os.rmdir, which we can
catch. But this also avoids the need to use the exception as a control
flow structure as it is used today.

At least in my mind, that is a lot easier to grasp than the if statement
in the exception handling, which I totally overlooked as it is an exception.

- Martin

--------------030208060209020003060206
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 01/10/13 15:18, Chris Larson wrote:
    <blockquote
cite="mid:CABcZANnD8C4gZXEcRWfR8f_ftZjndOT9UJ5796SEigRqw6tohA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Thu, Jan 10, 2013 at 7:11 AM,
            Chris Larson <span dir="ltr">&lt;<a moz-do-not-send="true"
                href="mailto:clarson@kergoth.com" target="_blank">clarson@kergoth.com</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div class="adM">
                <div class="h5"><br>
                  <div class="gmail_quote">On Thu, Jan 10, 2013 at 7:10
                    AM, Chris Larson <span dir="ltr">&lt;<a
                        moz-do-not-send="true"
                        href="mailto:clarson@kergoth.com"
                        target="_blank">clarson@kergoth.com</a>&gt;</span>
                    wrote:<br>
                    <blockquote class="gmail_quote" style="margin:0 0 0
                      .8ex;border-left:1px #ccc solid;padding-left:1ex">
                      <div>
                        <div class="gmail_quote">On Thu, Jan 10, 2013 at
                          1:46 AM, Martin Ertsaas <span dir="ltr">&lt;<a
                              moz-do-not-send="true"
                              href="mailto:martiert@gmail.com"
                              target="_blank">martiert@gmail.com</a>&gt;</span>
                          wrote:<br>
                          <blockquote class="gmail_quote"
                            style="margin:0 0 0 .8ex;border-left:1px
                            #ccc solid;padding-left:1ex">
                            <div>On mac, os.unlink does not remove
                              directories, and we therefor have<br>
                              to explicitly use shutil.rmtree if the
                              path is a directory.<br>
                              ---<br>
                               lib/bb/utils.py |    5 ++++-<br>
                               1 file changed, 4 insertions(+), 1
                              deletion(-)<br>
                              <br>
                              diff --git a/lib/bb/utils.py
                              b/lib/bb/utils.py<br>
                              index cef0fdd..8b6d3f5 100644<br>
                              --- a/lib/bb/utils.py<br>
                              +++ b/lib/bb/utils.py<br>
                              @@ -561,7 +561,10 @@ def remove(path,
                              recurse=False):<br>
                                   import os, errno, shutil, glob<br>
                                   for name in glob.glob(path):<br>
                                       try:<br>
                              -            os.unlink(name)<br>
                              +            if os.path.isdir(name):<br>
                              +                shutil.rmtree(name)<br>
                              +            else:<br>
                              +                os.unlink(name)<br>
                                       except OSError as exc:<br>
                                           if recurse and exc.errno ==
                              errno.EISDIR:<br>
                                               shutil.rmtree(name)</div>
                          </blockquote>
                        </div>
                        <br>
                        <br>
                      </div>
                      Look 2 lines down, where it checks to see if the
                      os.unlink failed due to it being a directory and
                      runs shutil.rmtree if that's the case.</blockquote>
                  </div>
                  <br>
                </div>
              </div>
              I'm guessing you're trying to use it without passing
              recurse=True.</blockquote>
          </div>
          <br>
          Having through about it further, I think it might be best to
          be alter the code to also handle the case where recurse==False
          and the path is a directory by calling os.rmdir(). Perhaps
          this would reduce confusion.<br>
          -- <br>
          Christopher Larson</div>
      </div>
    </blockquote>
    You think to recursively call remove on the children of the
    directory? Wouldn't something like:<br>
    <br>
    for name in glob.glob(path):<br>
        if os.path.isdir(name) and recurse:<br>
            shutil.rmtree(name)<br>
        elif os.path.isdir(name):<br>
            os.rmdir(name)<br>
        else:<br>
            os.unlink(name)<br>
    <br>
    Then we will possibly get an exception from os.rmdir, which we can
    catch. But this also avoids the need to use the exception as a
    control flow structure as it is used today.<br>
    <br>
    At least in my mind, that is a lot easier to grasp than the if
    statement in the exception handling, which I totally overlooked as
    it is an exception.<br>
    <br>
    - Martin<br>
  </body>
</html>

--------------030208060209020003060206--
