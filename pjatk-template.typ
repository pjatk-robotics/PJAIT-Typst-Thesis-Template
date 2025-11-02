
#let apply-pjatk-template(
    body,
    faculty: "Faculty of Computer Science",
    department: "Name of your Specialization's Department",
    specialization: "Name of your Specialization",
    authors: ("Your Name --- s#####",),
    title: "Your Thesis Title",
    supervisor: "Supervisor's Name",
    auxiliary-supervisor: "Auxiliary Supervisor's Name",
    language: "en"
) = {
    set document(title: title)

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
        weight: 400
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

    show raw: it => {
        box(
            radius: 4pt,
            fill: rgb(210, 235, 235, 80),
            outset: 2pt
        )[#it]
    }

    set enum(indent: 2em)
    set list(indent: 2em, marker: ([•], [◦]))
    set quote(block: true)

    show outline.entry.where(level: 1): it => {
        show text: it => strong(smallcaps(it))
        it
    }

    show outline.entry.where(level: 3): it => emph(it)

    show heading.where(level: 1): it => { pagebreak(weak: true, to: "odd"); it }

    {
        set page(margin: (top: 1in, bottom: 1.25in, left: 1.75in, right: 1.75in))
        image("PJATK_pl_poziom_1.pdf")

        align(center)[
            #v(2cm)

            #strong(faculty)

            #v(1cm)

            #strong(department)\
            #specialization

            #v(1cm)

            #eval(mode: "markup", authors.map(s => s.replace("#", "\#") + "\\").join("\n"))

            #v(1cm)

            #show title: it => strong(text(size: 2em, it))
            #title

            #v(1fr)

            #align(right)[
                #block(width: 5cm)[
                    #align(left)[
                        #context {
                            if text.lang == "pl" {
                                [Praca inżynierska / Praca magisterska napisana pod kierunkiem:]
                            } else {
                                [Master's degree / Bachelor's degree thesis written under the supervision of:]
                            }
                        }
                        #v(1em)
                        #strong(supervisor)\
                        #auxiliary-supervisor
                    ]
                ]
            ]

            #v(1fr)

            #context {
                if text.lang == "pl" {
                    [Warszawa]
                } else {
                    [Warsaw]
                }
            },
            #datetime.today().display("[month repr:long] [year]")
        ]
    }

    outline(target: heading)

    body

    bibliography(
        "references.bib"
    )
}

