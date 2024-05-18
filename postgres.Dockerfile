# Use the official PostgreSQL image
FROM postgres:latest

# Add environment variables
ENV POSTGRES_USER=names
ENV POSTGRES_PASSWORD=names
ENV POSTGRES_DB=namesdb
