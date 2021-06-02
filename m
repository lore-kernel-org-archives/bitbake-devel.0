Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web10.12917.1622640210711148514
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Jun 2021 06:23:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay10.mail.gandi.net (Postfix) with ESMTPSA id C4BC9240012;
	Wed,  2 Jun 2021 13:23:28 +0000 (UTC)
Cc: docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH] doc: user-manual: ref-manual: remove mentions to BB_SETSCENE_VERIFY_FUNCTION2
To: Quentin Schulz <foss@0leil.net>, bitbake-devel@lists.openembedded.org
References: <20210601192235.9371-1-foss@0leil.net>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <bb36e2b1-bc7b-3efd-b8b2-dc2718eb51d8@bootlin.com>
Date: Wed, 2 Jun 2021 15:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601192235.9371-1-foss@0leil.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Quentin,

On 6/1/21 9:22 PM, Quentin Schulz wrote:
> This variable was removed in July 2019 with commit
> 5deaa5df730a "runqueue: Drop unused BB_SETSCENE_VERIFY_FUNCTION2".
>
> There's no replacement, so let's update the documentation to not mention
> this variable anymore.
>
> This was found by running:
> git grep -hoP '^   :term:`\K\w+(?=`)' doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | \
>   xargs -I{} sh -c \
>     "grep -Rq --include='*.py' --include='*.conf' --include='*.bbclass' --include='*.bb' --include='*.bbappend' --include='*.inc' \
>       -w -E {}'_*(_[a-z]+[0-9a-z]*[a-z]+)*' || \
>     echo {}"
>
> Signed-off-by: Quentin Schulz <foss@0leil.net>
> ---
>  .../bitbake-user-manual-execution.rst                 |  7 -------
>  .../bitbake-user-manual-metadata.rst                  |  4 ----
>  .../bitbake-user-manual-ref-variables.rst             | 11 -----------
>  3 files changed, 22 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index 14c342a6..84d65fa9 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -648,13 +648,6 @@ compiled binary. To handle this, BitBake calls the
>  each successful setscene task to know whether or not it needs to obtain
>  the dependencies of that task.
>  
> -Finally, after all the setscene tasks have executed, BitBake calls the
> -function listed in
> -:term:`BB_SETSCENE_VERIFY_FUNCTION2`
> -with the list of tasks BitBake thinks has been "covered". The metadata
> -can then ensure that this list is correct and can inform BitBake that it
> -wants specific tasks to be run regardless of the setscene result.
> -
>  You can find more information on setscene metadata in the
>  :ref:`bitbake-user-manual/bitbake-user-manual-metadata:task checksums and setscene`
>  section.
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 77c107af..20c330e6 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1920,10 +1920,6 @@ The following list describes related variables:
>     Specifies a function BitBake calls that determines whether BitBake
>     requires a setscene dependency to be met.
>  
> --  :term:`BB_SETSCENE_VERIFY_FUNCTION2`:
> -   Specifies a function to call that verifies the list of planned task
> -   execution before the main task execution happens.
> -
>  -  :term:`BB_STAMP_POLICY`: Defines the mode
>     for comparing timestamps of stamp files.
>  
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index adb311ab..a1e2440b 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -426,17 +426,6 @@ overview of their function and contents.
>        The function specified by this variable returns a "True" or "False"
>        depending on whether the dependency needs to be met.
>  
> -   :term:`BB_SETSCENE_VERIFY_FUNCTION2`
> -      Specifies a function to call that verifies the list of planned task
> -      execution before the main task execution happens. The function is
> -      called once BitBake has a list of setscene tasks that have run and
> -      either succeeded or failed.
> -
> -      The function allows for a task list check to see if they make sense.
> -      Even if BitBake was planning to skip a task, the returned value of
> -      the function can force BitBake to run the task, which is necessary
> -      under certain metadata defined circumstances.
> -
>     :term:`BB_SIGNATURE_EXCLUDE_FLAGS`
>        Lists variable flags (varflags) that can be safely excluded from
>        checksum and dependency data for keys in the datastore. When

Thanks for the patch!

Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Tested-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

