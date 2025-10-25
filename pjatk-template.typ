
#let apply-pjatk-template(
    body,
    title: "Your Thesis Title",
    name-and-surname: "Your Name",
    supervisor: "Supervisor's Name",
    auxiliary-supervisor: "Auxiliary Supervisor's Name",
    specialization: "Name of your Specialization",
    department: "Name of your Specialization's Department",
    language: "pl"
) = {
    set page(
        paper: "a4",
        margin: (top: 1in, bottom: 1.25in, left: 1.5in, right: 1.5in),
        footer: context {
            set align(center)
            counter(page).display("1")
        }
    )

    set text(
        size: 12pt,
        font: "EB Garamond",
        lang: language,
    )

    set par(justify: true)

    set heading(numbering: "1.1")

    show ref: it => {
        if it.element != none and it.element.func() == heading {
            return link(
                it.element.location(),
                    context {
                        strong[
                            #numbering(
                                it.element.numbering,
                                ..counter(heading).at(it.element.location()),
                            )
                            #it.element.body
                        ]
                    },
            )
        }
        it
    }

    show raw: it => [
        #h(1pt)
        #box(
            radius: 4pt,
            fill: rgb(210, 235, 235, 80),
            outset: 2pt
        )[#it]
    ]

    set enum(indent: 2em)
    set list(indent: 2em, marker: ([•], [◦]))
    set quote(block: true)

    show outline.entry.where(level: 1): it => {
        show text: it => strong(smallcaps(it))
        it
    }

    show outline.entry.where(level: 3): it => emph(it)

    show heading.where(level: 1): it => { pagebreak(weak: true, to: "odd"); it }

    outline(target: heading)

    body

    bibliography(
        "references.bib"
    )
}

